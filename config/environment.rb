# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rewriter::Application.initialize!

#replace the wrapping of error fields with a span, rather than a DIV to allow floating around these elements (Any better method?)
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  '<span class="field_with_errors">'.html_safe << html_tag << '</span>'.html_safe
end
