require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Memcache < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/memcache'
  url 'http://pecl.php.net/get/memcache-2.2.6.tgz'
  sha1 'be0b12fa09ed127dc35c0da29a576a9112be1bde'
  head 'https://svn.php.net/repository/pecl/memcache/trunk/', :using => :svn

  def install
    Dir.chdir "memcache-#{version}" unless build.head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/memcache.so"
    write_config_file unless build.include? "without-config-file"
  end
end
