module ApplicationHelper
  def svg_pack_tag(icon_name, options={})
    file = File.read(Rails.root.join('app', 'javascript', 'images', "#{icon_name}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'

    options.each {|attr, value| svg[attr.to_s] = value}

    doc.to_html.html_safe
  end
end
