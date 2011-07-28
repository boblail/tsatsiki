# In order for different projects managed by Tsatsiki to 
# be able to run in their respective Bundler environments
# (presumably different from Tsatsiki's own environment!),
# I need this commit:
#
#   https://github.com/carlhuda/bundler/commit/4faa8e4a24d4665d1a4eabb4c64e00c90b2cb827
# 
# However, I don't want to rely on Bundler 1.1 prelease
# because it seems to be introducing problems for this and
# other applications.
#
# c.f. https://github.com/carlhuda/bundler/issues/900
# c.f. http://spectator.in/2011/01/28/bundler-in-subshells/

module Bundler
  
  
  
  def with_original_env
    bundled_env = ENV.to_hash
    ENV.replace(ORIGINAL_ENV)
    yield
  ensure
    ENV.replace(bundled_env.to_hash)
  end
  
  def with_clean_env
    with_original_env do
      ENV.delete_if { |k,_| k[0,7] == 'BUNDLE_' }
      yield
    end
  end
  
  def clean_system(*args)
    with_clean_env { Kernel.system(*args) }
  end
  
  def clean_exec(*args)
    with_clean_env { Kernel.exec(*args) }
  end
  
  
  
end