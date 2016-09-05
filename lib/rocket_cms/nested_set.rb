require 'rails_admin_nested_set/helper'

module RailsAdminNestedSet::Helper
  def extra_fields(node)
    if node.class.name == 'Page'
      ret = RocketCMS::Menu.build_toggles(self, node.class, node, 'xs', '')
      ('<div style="white-space: normal; display: inline-block; margin-left: 10px;">' + ret.join(' ') + '</div>').html_safe
    else
      "".html_safe
    end
  end
end

