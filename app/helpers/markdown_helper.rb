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

  def markdown_links_to_html(text)
    sanitized_text = sanitize(text)
    regex = /\[(.*?)\]\((http[s]?:\/\/.*?|mailto:.*?)\)/
    html_text = sanitized_text.gsub(regex) do
      link_text = Regexp.last_match(1)
      link_url = Regexp.last_match(2)
      # Check if it's a mailto link
      if link_url.start_with?('mailto:')
        ActionController::Base.helpers.link_to(link_text, link_url)
      else
        ActionController::Base.helpers.link_to(link_text, link_url, target: '_blank', rel: 'noopener', class: '')
      end
    end
  
    html_text.html_safe
  end
  
     
  
end