AC_PREREQ(2.59)
AC_COPYRIGHT([Copyright (c) 2015 UPLEX Nils Goroll Systemoptimierung])
AC_INIT([VMOD backend_dyn], [0.4], [varnish-support@uplex.de],
        [libvmod-backend_dyn],
	[https://code.uplex.de/uplex-varnish/libvmod-gcrypt])
AC_CONFIG_MACRO_DIR([m4])
m4_ifndef([VARNISH_VMOD_INCLUDES],
          AC_MSG_ERROR([Need varnish.m4 -- see INSTALL.rst]))
AC_CONFIG_SRCDIR(src/vmod.vcc)
AM_CONFIG_HEADER(config.h)

AC_CANONICAL_SYSTEM
AC_LANG(C)

AM_INIT_AUTOMAKE([foreign])

AC_PROG_CC
AC_PROG_CC_STDC
if test "x$ac_cv_prog_cc_c99" = xno; then
	AC_MSG_ERROR([Could not find a C99 compatible compiler])
fi
AC_PROG_CPP

AC_PROG_INSTALL
AC_PROG_LIBTOOL
AC_PROG_MAKE_SET

# Check for rst utilities
AC_CHECK_PROGS(RST2MAN, [rst2man rst2man.py], "no")
if test "x$RST2MAN" = "xno"; then
	AC_MSG_WARN([rst2man not found - not building man pages])
fi
AM_CONDITIONAL(HAVE_RST2MAN, [test "x$RST2MAN" != "xno"])

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADER([sys/types.h])
AC_CHECK_HEADER([sys/socket.h])
AC_CHECK_HEADER([netdb.h])

AC_FUNC_MALLOC
AC_CHECK_FUNCS([memset])

# backwards compat with older pkg-config
# - pull in AC_DEFUN from pkg.m4
m4_ifndef([PKG_CHECK_VAR], [
# PKG_CHECK_VAR(VARIABLE, MODULE, CONFIG-VARIABLE,
# [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# -------------------------------------------
# Retrieves the value of the pkg-config variable for the given module.
AC_DEFUN([PKG_CHECK_VAR],
[AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
AC_ARG_VAR([$1], [value of $3 for $2, overriding pkg-config])dnl

_PKG_CONFIG([$1], [variable="][$3]["], [$2])
AS_VAR_COPY([$1], [pkg_cv_][$1])

AS_VAR_IF([$1], [""], [$5], [$4])dnl
])# PKG_CHECK_VAR
])

PKG_CHECK_MODULES([libvarnishapi], [varnishapi = 5.0.0])
PKG_CHECK_VAR([LIBVARNISHAPI_PREFIX], [varnishapi], [prefix])
PKG_CHECK_VAR([LIBVARNISHAPI_DATAROOTDIR], [varnishapi], [datarootdir])
PKG_CHECK_VAR([LIBVARNISHAPI_BINDIR], [varnishapi], [bindir])
PKG_CHECK_VAR([LIBVARNISHAPI_SBINDIR], [varnishapi], [sbindir])
AC_SUBST([LIBVARNISHAPI_DATAROOTDIR])

# Varnish include files tree
VARNISH_VMOD_INCLUDES
VARNISH_VMOD_DIR
VARNISH_VMODTOOL
# inherit the prefix from Varnish.
# acessing ac_ variable because AC_PREFIX_DEFAULT acts too early
ac_default_prefix=$LIBVARNISHAPI_PREFIX

AC_PATH_PROG([VARNISHTEST], [varnishtest], [],
    [$LIBVARNISHAPI_BINDIR:$LIBVARNISHAPI_SBINDIR:$PATH])
AC_PATH_PROG([VARNISHD], [varnishd], [],
    [$LIBVARNISHAPI_SBINDIR:$LIBVARNISHAPI_BINDIR:$PATH])

# --enable-stack-protector
AC_ARG_ENABLE(stack-protector,
       AS_HELP_STRING([--enable-stack-protector],[enable stack protector (default is YES)]),
       [],
       [enable_stack_protector=yes])

if test "x$enable_stack_protector" != "xno"; then
	AX_CHECK_COMPILE_FLAG([-fstack-protector],
		AX_CHECK_LINK_FLAG([-fstack-protector],
			[DEVELOPER_CFLAGS="${DEVELOPER_CFLAGS} -fstack-protector"], [], []),
		[], [])
fi

# --enable-debugging
AC_ARG_ENABLE(debugging,
	AS_HELP_STRING([--enable-debugging],[enable debugging (default is NO)]),
	[],
	[enable_debugging=no])

# AC_PROG_CC sets CFLAGS to '-g -O2' unless it is already set, so
# there's no need to add -g. Disable or change by explicitly setting
# CFLAGS. If this option is enabled, then -Og or -O0 becomes the last
# optimization option, and hence takes precedence.
if test "x$enable_debugging" != "xno"; then
	CFLAGS="${CFLAGS} -fno-inline"
	AX_CHECK_COMPILE_FLAG([-Og],
		[CFLAGS="${CFLAGS} -Og"],
		[CFLAGS="${CFLAGS} -O0"],
		[])
fi

AC_CONFIG_FILES([
	Makefile
	src/Makefile
])
AC_OUTPUT
