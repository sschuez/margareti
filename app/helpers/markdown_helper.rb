require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

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
end