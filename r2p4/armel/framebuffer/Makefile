include ../../../../../Makefile.setup

install: libMali.so libEGL.so libGLESv1_CM.so libGLESv2.so
	$(INSTALL_DATA) $^ $(libdir)

	$(RM) $(libdir)libEGL.so.1 $(libdir)libEGL.so.1.4
	$(RM) $(libdir)libGLESv1_CM.so.1 $(libdir)libGLESv1_CM.so.1.1
	$(RM) $(libdir)libGLESv2.so.2 $(libdir)libGLESv2.so.2.0
