# frozen_string_literal: true

# @ripienaar https://www.devco.net/archives/2010/11/18/a_few_rake_tips.php
# Brilliant.
def render_template(template, output, scope)
  tmpl = File.read(template)
  erb = ERB.new(tmpl, 0, '<>-')
  File.open(output, 'w') do |f|
    f.puts erb.result(scope)
  end
end
