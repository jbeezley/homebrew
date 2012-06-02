require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Itk < Formula
  homepage 'http://www.itk.org'
  url 'http://sourceforge.net/projects/itk/files/itk/4.1/InsightToolkit-4.1.0.tar.xz/download'
  md5 '5dd05b4aa272f745e0897da2bcf37a34'

  depends_on 'cmake' => :build

  def install
    args = std_cmake_args + [
		     "-DBUILD_TESTING:BOOL=OFF",
			 "-DBUILD_EXAMPLES:BOOL=OFF",
			 "-DBUILD_SHARED_LIBS:BOOL=ON",
			 "-DCMAKE_INSTALL_RPATH:STRING='#{lib}/itk-4.1'",
			 "-DCMAKE_INSTALL_NAME_DIR:STRING='#{lib}/itk-4.1'"]

	args << "-DCMAKE_BUILD_WITH_INSTALL_RPATH:BOOL=ON"
	ENV['DYLD_LIBRARY_PATH'] = buildpath/'build/bin'
	args << ".."
	
	mkdir 'build' do
		system "cmake", ".", *args
		lib.mkpath
		ln_s ENV['DYLD_LIBRARY_PATH'], lib/'itk-5.8'
		system "make"
		rm lib/'itk-5.8'
		system "make install"
	end
  end

  def test
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test itk`.
    system "false"
  end
end
