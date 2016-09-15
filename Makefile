
BUILDDIR=build

BUILDTMP=build_tmp

.PHONY: all package publish
all:

package:
	rm -rf ${BUILDDIR} ${BUILDTMP}
	mkdir -p ${BUILDDIR}/usr/bin ${BUILDTMP}
	cp hello-world.sh ${BUILDDIR}/usr/bin/hello-world
	pkgsend generate build | pkgfmt > ${BUILDTMP}/pkg.pm5.1

	pkgmogrify ${BUILDTMP}/pkg.pm5.1 metadata.mog transform.mog | pkgfmt > ${BUILDTMP}/pkg.pm5.2
        
	cp ${BUILDTMP}/pkg.pm5.2 ${BUILDTMP}/pkg.pm5.final

	pkglint ${BUILDTMP}/pkg.pm5.final
	
publish: 
ifndef PKGSRVR
	echo "Need to define PKGSRVR, something like http://localhost:10000"
	exit 1
endif
	pkgsend publish -s ${PKGSRVR} -d ${BUILDDIR} ${BUILDTMP}/pkg.pm5.final

