module HerokuConfigVars
  module ApplicationHelper
    def menu_link(text, url, html_options={})
      text = content_tag :span, text, :class => 'menu-option'
      link_to_unless_current text, url, html_options
    end
  end
end
