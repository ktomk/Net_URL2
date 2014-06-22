<?php
/**
 * Net_URL2, a class representing a URL as per RFC 3986.
 *
 * PHP version 5
 *
 * This file contains code Copyright (c) 2002-2003, Richard Heyes,
 * See BSD-3-CLAUSE-Heyes,
 * Author: Richard Heyes <richard at php net>
 *
 * @category Networking
 * @package  Net_URL2
 * @author   Some Pear Developers <pear@php.net>
 * @license  https://spdx.org/licenses/BSD-3-Clause BSD-3-Clause
 * @link     https://tools.ietf.org/html/rfc3986
 */

/**
* This example will decode the url given and display its
* constituent parts.
*/

error_reporting(E_ALL | E_STRICT);

require 'Net/URL2.php';

$url = new Net_URL2(
    'https://user:pass@example.com/pls/portal30/PORTAL30.wwpob_page.changetabs?'
    .'p_back_url=http%3A%2F%2Fexample.com%2Fservlet%2Fpage%3F_pageid%3D360'
    .'%2C366%2C368%2C382%26_dad%3Dportal30%26_schema%3DPORTAL30&foo=bar'
);

?>
<html>
<body>

<pre>
Protocol...: <?php echo @$url->protocol; ?> (dead property)

Protocol...: <?php echo $url->getScheme(); ?>

Username...: <?php echo $url->user; ?> (deprecated property)

Username...: <?php echo $url->getUser(); ?>

Password...: <?php echo $url->pass; ?> (dead property)

Password...: <?php echo $url->getPassword(); ?>

Server.....: <?php echo $url->host; ?> (deprecated property)

Server.....: <?php echo $url->getHost(); ?>

Port.......: <?php $url->port; ?> (deprecated property)

Port.......: <?php $url->getPort(); ?>

File/path..: <?php $url->path; ?> (deprecated property)

Querystring: <?php print_r($url->querystring); ?> (dead property)

Anchor.....: <?php echo $url->anchor; ?> (dead property)

Anchor.....: <?php echo $url->getFragment(); ?>

Full URL...: <?php echo $url->getUrl(); ?>


Resolve path (.././/foo/bar/joe/./././../jabba): <b><?php
        echo $url->resolve('.././/foo/bar/joe/./././../jabba'); ?></b>
</pre>

</body>
</html>
