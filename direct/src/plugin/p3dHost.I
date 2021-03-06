/**
 * PANDA 3D SOFTWARE
 * Copyright (c) Carnegie Mellon University.  All rights reserved.
 *
 * All use of this software is subject to the terms of the revised BSD
 * license.  You should have received a copy of this license along
 * with this source code in a file named "LICENSE."
 *
 * @file p3dHost.I
 * @author drose
 * @date 2009-08-21
 */

/**
 * Returns true if the host_dir has already been set, false if not.  If this
 * returns true it is safe to call get_host_dir().
 */
inline bool P3DHost::
has_host_dir() const {
  return (!_host_dir.empty());
}

/**
 * Returns the local directory into which files downloaded from this host will
 * be installed.  It may not be safe to call this before the host has fully
 * bootstrapped; if there is some danger of calling this early in the
 * initialization process, you should check has_host_dir() first.
 */
inline const string &P3DHost::
get_host_dir() const {
  assert(has_host_dir());
  return _host_dir;
}

/**
 * Returns the root URL of this particular host, as passed from the package
 * file.  This is a unique string that identifies each host.
 */
inline const string &P3DHost::
get_host_url() const {
  return _host_url;
}

/**
 * Returns the root URL of this host, for constructing the URL to download
 * contents.xml only.  This is the same as get_host_url(), except it is
 * guaranteed to end in a slash character.
 *
 * Also see get_download_url_prefix().
 */
inline const string &P3DHost::
get_host_url_prefix() const {
  return _host_url_prefix;
}

/**
 * Returns the root URL of this host, for downloading everything other than
 * the contents.xml file.  This is often the same as get_host_url_prefix(),
 * but it may be different in the case of an https server for contents.xml.
 */
inline const string &P3DHost::
get_download_url_prefix() const {
  return _download_url_prefix;
}

/**
 * Returns the descriptive name provided for this host, if any.  Returns the
 * url if no descriptive name is provided.  This will be available after
 * read_contents_file() has been called.
 */
inline const string &P3DHost::
get_descriptive_name() const {
  return _descriptive_name;
}

/**
 * Returns true if a contents.xml file has been successfully read for this
 * host, false otherwise.
 */
inline bool P3DHost::
has_contents_file() const {
  return (_xcontents != nullptr);
}

/**
 * Returns a number that increments whenever a new version of the contents.xml
 * file has been read.  This number is local to the session only; it has
 * nothing to do with the "seq" value written into the contents.xml file
 * itself.
 *
 * This can be used by packages to determine whether they need to redownload
 * from scratch.
 */
inline int P3DHost::
get_contents_iseq() const {
  return _contents_iseq;
}

/**
 * Returns true if the indicated pathname has the same md5 hash as the
 * contents.xml file (as provided by the server), false otherwise.
 */
inline bool P3DHost::
check_contents_hash(const string &pathname) const {
  return _contents_spec.check_hash(pathname);
}
