class NoExtraUl < SimpleNavigation::Renderer::List
  def render_sub_navigation_for(item)
    r = super(item)
    if r.strip == '<ul></ul>'
      ''
    else
      r
    end
  end
end
