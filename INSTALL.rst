INSTALLATION
============

The VMOD is built against a Varnish installation, and the autotools
use ``pkg-config(1)`` to locate the necessary header files and other
resources. This sequence will install the VMOD::

  > ./autogen.sh	# for builds from the git repo
  > ./configure
  > make
  > make check		# to run unit tests in src/tests/*.vtc
  > sudo make install

The configure step requires code from the Autoconf Archive collection
of m4 macros. If you encounter difficulties in the ``configure`` step,
make sure that you have the archive installed (typically as the
package ``autoconf-archive`` on many distributions).

If you have installed Varnish in a non-standard directory, call
``autogen.sh`` and ``configure`` with the ``PKG_CONFIG_PATH``
environment variable pointing to the appropriate path. For example,
when varnishd configure was called with ``--prefix=$PREFIX``, use::

  > PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
  > export PKG_CONFIG_PATH

By default, the vmod ``configure`` script installs the vmod in
the same directory as Varnish, determined via ``pkg-config(1)``. The
vmod installation directory can be overridden by passing the
``VMOD_DIR`` variable to ``configure``.

Other files such as the man-page are installed in the locations
determined by ``configure``, which inherits its default ``--prefix``
setting from Varnish.
