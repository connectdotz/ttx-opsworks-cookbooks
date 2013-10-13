#
##### monit ####
#

#include_attribute "monit"
default[:ttx][:monit][:conf_dir] = '/etc/monit.d'
default[:ttx][:monit][:mailto] = 'ops@thingtrix.com'