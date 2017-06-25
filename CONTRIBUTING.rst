CONTRIBUTING
============

To contribute code or documentation, submit a pull request at the
`source repository website
<https://code.uplex.de/uplex-varnish/libvmod-backend_dyn>`_.

If you have a problem or discover a bug, you can post an `issue
<https://code.uplex.de/uplex-varnish/libvmod-backend_dyn/issues>`_ at
the website. You can also write to <varnish-support@uplex.de>.

For developers
--------------

The build specifies C99 conformance, all compiler warnings turned on,
and all warnings considered errors (compiler options ``-std=c99
-Werror -Wall -Wextra``).

The VMOD has been tested with both the gcc and clang compilers, and
should always compile and test successfully with both of them.

By default, ``CFLAGS`` is set to ``-g -O2``, so that symbols are
included in the shared library, and optimization is at level
``O2``. To change or disable these options, set ``CFLAGS`` explicitly
before calling ``make`` (it may be set to the empty string).

For development/debugging cycles, the ``configure`` option
``--enable-debugging`` is recommended (off by default). This will turn
off optimizations and function inlining, so that a debugger will step
through the code as expected.
