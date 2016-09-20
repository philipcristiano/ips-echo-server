
BUILDDIR=build

BUILDTMP=build_tmp

.PHONY: all package publish
all:

package:
	rm -rf ${BUILDDIR} ${BUILDTMP}
	mkdir -p ${BUILDDIR}/usr/bin ${BUILDTMP}
	mkdir -p ${BUILDDIR}/lib/svc/manifest/application/

	cp smf-echo-server.sh ${BUILDDIR}/usr/bin/echo-server
	cp smf.xml ${BUILDDIR}/lib/svc/manifest/application/echo-server.xml
	pkgsend generate build | pkgfmt > ${BUILDTMP}/pkg.pm5.1
	cp LICENSE ${BUILDDIR}/

	pkgmogrify ${BUILDTMP}/pkg.pm5.1 metadata.mog transform.mog | pkgfmt > ${BUILDTMP}/pkg.pm5.2

	cp ${BUILDTMP}/pkg.pm5.2 ${BUILDTMP}/pkg.pm5.final

	pkglint ${BUILDTMP}/pkg.pm5.final

publish:
ifndef PKGSRVR
	echo "Need to define PKGSRVR, something like http://localhost:10000"
	exit 1
endif
	pkgsend publish -s ${PKGSRVR} -d ${BUILDDIR} ${BUILDTMP}/pkg.pm5.final
	pkgrepo refresh -s ${PKGSRVR}

