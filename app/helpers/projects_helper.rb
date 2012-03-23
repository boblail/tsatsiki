module ProjectsHelper
  
  
  
  def project_statistics(*names)
    names.map(&method(:project_statistic)).join.html_safe
  end
  
  def project_statistic(name)
    predicate = "#{name.to_s.singularize}?".to_sym
    html = \
    <<-HTML
    <li class="project-statistic">
      <a href="##{name}" class="toggle project-statistic-button">
        <span class="project-statistic-count">#{@project.scenarios.reject(&:ignore?).select(&predicate).count}</span>
        <span class="project-statistic-label">#{name.to_s.titleize}</span>
      </a>
    </li>
    HTML
    html.html_safe
  end
  
  
  
  def project_features_class
    (request.path =~ /projects\/\d+\/features/) && "selected"
  end
  
  def project_specification_class
    (request.path =~ /projects\/\d+\/specification/) && "selected"
  end
  
  def edit_project_class
    (request.path =~ /projects\/\d+\/edit/) && "selected"
  end
  
  
  
end
