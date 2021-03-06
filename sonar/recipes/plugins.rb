# installs common sonar plugins used enterprise wide
#

#sonar_plugin 'sonar-build-breaker-plugin'
sonar_plugin 'sonar-taglist-plugin'
sonar_plugin 'sonar-crowd-plugin'
sonar_plugin 'sonar-googleanalytics-plugin'

sonar_plugin 'sonar-technicaldebt-plugin' do
  version '1.2.1'
end

sonar_plugin 'sonar-android-plugin' do
  version '0.1'
  repo_url 'http://repository.codehaus.org/org/codehaus/sonar-plugins/android/'
end

sonar_plugin 'sonar-jbehave-plugin' do
  version '1.0.2'
  repo_url 'http://mvnproxy.eden.klm.com/content/repositories/kl-releases/com/klm/eden/jbehave/'
end

sonar_plugin 'sonar-javascript-plugin' do
  version '1.4'
  repo_url 'http://repository.codehaus.org/org/codehaus/sonar-plugins/javascript'
end

#sonar_plugin 'sonar-motion-chart-plugin' do
#  version '1.5'
#end
