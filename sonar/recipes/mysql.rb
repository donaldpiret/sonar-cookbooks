# Database settings
# @see conf/sonar.properties for examples for different databases
node.default[:sonar][:jdbc_url]             = 'jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8'

include_recipe 'sonar::default'
include_recipe 'sonar::database_mysql'