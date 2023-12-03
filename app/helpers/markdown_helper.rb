require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'uri'

module MarkdownHelper
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end
  
  def markdown(text)
    return '' if text.nil?
    
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
      prettify: true,
      space_after_headers: true
    }
    
    extensions = {
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      no_intra_emphasis: true,
      strikethrough: true,
      superscript: true,
      disable_indented_code_blocks: true,
    }
    
    Redcarpet::Markdown.new(HTML.new(options), extensions).render(text).html_safe
  end

  # This method finds markdown links in the text and converts them to HTML links.
  # The pattern [text](url) is converted to <a href="url">text</a>.
  def markdown_links_to_html(text)
    # Escape any characters that could interfere with HTML rendering
    sanitized_text = sanitize(text)

    # Use a regular expression to find markdown links and replace them with HTML links.
    # The pattern captures the link text in the first group and the URL in the second group.
    regex = /\[([^\]]+)\]\((http[s]?:\/\/[^\)]+)\)/
    html_text = sanitized_text.gsub(regex) do
      link_text = $1
      link_url = $2
      # Generate an anchor tag for the link
      ActionController::Base.helpers.link_to(link_text, link_url, target: '_blank', rel: 'noopener')
    end

    # Return the modified text with HTML links
    html_text.html_safe
  end
end