require 'redcarpet'

module ApplicationHelper
    def markdown(text)
        options = {
          filter_html:     true,
          highlight:       true,
          hard_wrap:       true,
          link_attributes: { rel: 'nofollow', target: "_blank" },
          space_after_headers: true,
          fenced_code_blocks: false
        }
    
        extensions = {
          autolink:           true,
          superscript:        true,
          disable_indented_code_blocks: false
        }
    
        renderer = Redcarpet::Render::HTML.new(options)
        markdown = Redcarpet::Markdown.new(renderer, extensions)
    
        markdown.render(text).html_safe
    end
end
