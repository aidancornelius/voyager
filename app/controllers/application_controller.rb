class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_administrator!
    if current_user && current_user.is_administrator?

    else
      redirect_to root_url, notice: "Sorry, you need administrative privileges to do that..."
    end
  end

  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
  end

  def current_user_purchased?
    if current_user
      if current_user.billing
        if current_user.billing.success?
          true
        else
          false
        end
      else
        false
      end
    else
      false
    end
  end

  def message_user(user_id, title, message, link)
    @message = Message.new(
      user_id: user_id,
      title: title,
      body: message,
      link: link,
      read: false
    )
    @message.save
  end

  def not_purchased!
    if !current_user_purchased?
      # okay
    else
      redirect_to billing_path, alert: "Sorry, you already own Assessment Ninja."
    end
  end

  def purchase_first!
    if current_user_purchased?
      # okay
    else
      redirect_to new_billing_path, alert: "Sorry, you need to buy Assessment Ninja before you can do that."
    end
  end

  def mdrender(content)
    content = content
    # Setup a nice pipeline, with some pretty filters...
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::ImageMaxWidthFilter,
      HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::AutolinkFilter,
      HTML::Pipeline::AssetIser,
      HTML::Pipeline::VideoiFramer
    ], { asset_root: "https://assets-cdn.github.com/images/icons/emoji/unicode" }
    result = pipeline.call(content)
    # Give it back...
    return result[:output].to_s
  end

  def notify_slack(message, attachments, target = "everyone")
    require 'slack-notifier'
    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
    if target != "everyone"
      notifier.ping "Hey @#{target}, #{message}", attachments: [attachments]
    else
      notifier.ping "Hey <!everyone|everyone>, #{message}", attachments: [attachments]
    end
  end

  helper_method :mdrender, :emojify, :notify_slack, :current_user_purchased?, :purchase_first!
end


# Converts <img src="asset name.svg"> to src="/asset/name-1293182412.svg"
class AssetIser < HTML::Pipeline::Filter

  def call
    doc.search("img").each do |img|
      next if img['src'].nil?
      src = img['src'].strip
      if src.start_with? 'asset'
        img["src"] = "#{ActionController::Base.helpers.asset_path(src.to_s.split('%20').last)}"
      end
    end
    doc
  end

end

# Converts <iframe src...> to <iframe src... class="embed-responsive-item" allowfullscreen webkitallowfullscreen mozallowfullscreen
class VideoiFramer < HTML::Pipeline::Filter

  def call
    doc.search("iframe").each do |iframe|
      next if iframe['src'].nil?
      src = iframe['src'].strip
      iframe.replace('<iframe class="embed-responsive-item" src="' + src + '" allowfullscreen webkitallowfullscreen mozallowfullscreen></iframe>')
    end
    doc
  end

end
