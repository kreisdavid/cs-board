module PostsHelper
  
=begin
 This function configures and creates a new markdown object. 
 This should be called in the post views.
 The markdown rendered takes in text, and outputs html.
 It can create things like list tags, header tags, and 
 code tags. 
 checkout https://github.com/vmg/redcarpet for more information
=end
  def markdown(text)
    
    extensions = {
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      autolink: true
    }
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
  
  # Grabs color of the tag from the static class
  def get_color(tag)
    return Tag.instance.get_color(tag)
  end
end
