# Location for the webdot cgi program
CGI-BIN_DIR=/var/www/cgi-bin

# Location for some example web pages using webdot
HTML_DIR=/var/www/html

# A place that the webdot cgi program can cache its generated images
# (make install creates a webdot subdirectory in this dir.)
CACHE_DIR=/var/cache

# location of some TrueType fonts.
# Minimally times.ttf is required in this # directory.
DOTFONTPATH=/usr/share/ttf

# The uid:gid in effect when cgi-bin programs are running, only this
# user should be able to read/write the webdot cache.
HTTPD-USER-GROUP=apache:apache

# Location of tclsh8.3 (or later) executable
TCLSH_EXECUTABLE=/usr/bin/tclsh8.3

# Direct reference to libtcldot.so to avoid directory searching overhead
# of tcl package mechanism.
LIBTCLDOT=/usr/lib/graphviz/libtcldot.so

# Ghostscript is used for pdf output format
GS=/usr/bin/gs

# ps2epsi for epsi output format
PS2EPSI=/usr/bin/ps2epsi

# LOCALHOSTONLY set to 0 to allow conversion of graphs from other hosts
#      warning: use only if you want to provide a public graph server
#      this can result in uncontrolled load on your system
LOCALHOSTONLY=1


###############################################################


all:
	true

install:
	echo "#!$(TCLSH_EXECUTABLE)" > $(CGI-BIN_DIR)/webdot
	echo "set LIBTCLDOT $(LIBTCLDOT)" >> $(CGI-BIN_DIR)/webdot
	echo "set CACHE_ROOT $(CACHE_DIR)/webdot" >> $(CGI-BIN_DIR)/webdot
	echo "set env(DOTFONTPATH) $(DOTFONTPATH)" >> $(CGI-BIN_DIR)/webdot
	echo "set GS $(GS)" >> $(CGI-BIN_DIR)/webdot
	echo "set PS2EPSI $(PS2EPSI)" >> $(CGI-BIN_DIR)/webdot
	echo "set LOCALHOSTONLY  $(LOCALHOSTONLY)" >> $(CGI-BIN_DIR)/webdot
	cat cgi-bin/webdot >> $(CGI-BIN_DIR)/webdot
	chmod +x $(CGI-BIN_DIR)/webdot
	cp -r html/webdot $(HTML_DIR)
	rm -rf $(CACHE_DIR)/webdot
	mkdir $(CACHE_DIR)/webdot
	chown $(HTTPD-USER-GROUP) $(CACHE_DIR)/webdot
	chmod 700 $(CACHE_DIR)/webdot

uninstall:
	rm -f $(CGI-BIN_DIR)/webdot
	rm -rf $(HTML_DIR)/webdot
	rm -rf $(CACHE_DIR)/webdot
