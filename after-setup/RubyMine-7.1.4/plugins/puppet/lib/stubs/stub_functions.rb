module Puppet::Parser::Functions
  newfunction(:alert) do |args|
    desc <<EOT
<p>Log a message on the server at level alert.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>

<h2 id="asserttype">assert_type</h2>
<p>Returns the given value if it is an instance of the given type, and raises an error otherwise.
Optionally, if a block is given (accepting two parameters), it will be called instead of raising
an error. This to enable giving the user richer feedback, or to supply a default value.</p>

<p>Example: assert that <code>$b</code> is a non empty <code>String</code> and assign to <code>$a</code>:</p>

<p>$a = assert_type(String[1], $b)</p>

<p>Example using custom error message:</p>

<p>$a = assert_type(String[1], $b) |$expected, $actual| {
    fail(‘The name cannot be empty’)
  }</p>

<p>Example, using a warning and a default:</p>

<p>$a = assert_type(String[1], $b) |$expected, $actual| {
    warning(‘Name is empty, using default’)
    ‘anonymous’
  }</p>

<p>See the documentation for ‘The Puppet Type System’ for more information about types.
- since Puppet 3.7
- requires future parser/evaluator</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:contain) do |args|
    desc <<EOT
<p>Contain one or more classes inside the current class. If any of
these classes are undeclared, they will be declared as if called with the
<code>include</code> function. Accepts a class name, an array of class names, or a
comma-separated list of class names.</p>

<p>A contained class will not be applied before the containing class is
begun, and will be finished before the containing class is finished.</p>

<p>When the future parser is used, you must use the class’s full name;
relative names are no longer allowed. In addition to names in string form,
you may also directly use Class and Resource Type values that are produced by
the future parser’s resource and relationship expressions.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>

<h2 id="createresources">create_resources</h2>
<p>Converts a hash into a set of resources and adds them to the catalog.</p>

<p>This function takes two mandatory arguments: a resource type, and a hash describing
a set of resources. The hash should be in the form <code>{title =&gt; {parameters} }</code>:</p>

<pre><code># A hash of user resources:
$myusers = {
  'nick' =&gt; { uid    =&gt; '1330',
              gid    =&gt; allstaff,
              groups =&gt; ['developers', 'operations', 'release'], },
  'dan'  =&gt; { uid    =&gt; '1308',
              gid    =&gt; allstaff,
              groups =&gt; ['developers', 'prosvc', 'release'], },
}

create_resources(user, $myusers)
</code></pre>

<p>A third, optional parameter may be given, also as a hash:</p>

<pre><code>$defaults = {
  'ensure'   =&gt; present,
  'provider' =&gt; 'ldap',
}

create_resources(user, $myusers, $defaults)
</code></pre>

<p>The values given on the third argument are added to the parameters of each resource
present in the set given on the second argument. If a parameter is present on both
the second and third arguments, the one on the second argument takes precedence.</p>

<p>This function can be used to create defined resources and classes, as well
as native resources.</p>

<p>Virtual and Exported resources may be created by prefixing the type name
with @ or @@ respectively.  For example, the $myusers hash may be exported
in the following manner:</p>

<pre><code>create_resources("@@user", $myusers)
</code></pre>

<p>The $myusers may be declared as virtual resources using:</p>

<pre><code>create_resources("@user", $myusers)
</code></pre>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:crit) do |args|
    desc <<EOT
<p>Log a message on the server at level crit.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:debug) do |args|
    desc <<EOT
<p>Log a message on the server at level debug.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:defined) do |args|
    desc <<EOT
<p>Determine whether
 a given class or resource type is defined. This function can also determine whether a
 specific resource has been declared, or whether a variable has been assigned a value
 (including undef…as opposed to never having been assigned anything). Returns true
 or false. Accepts class names, type names, resource references, and variable
 reference strings of the form ‘$name’.  When more than one argument is
 supplied, defined() returns true if any are defined.</p>

<p>The <code>defined</code> function checks both native and defined types, including types
 provided as plugins via modules. Types and classes are both checked using their names:</p>

<pre><code> defined("file")
 defined("customtype")
 defined("foo")
 defined("foo::bar")
 defined('$name')
</code></pre>

<p>Resource declarations are checked using resource references, e.g.
 <code>defined( File['/tmp/myfile'] )</code>. Checking whether a given resource
 has been declared is, unfortunately, dependent on the parse order of
 the configuration, and the following code will not work:</p>

<pre><code> if defined(File['/tmp/foo']) {
     notify { "This configuration includes the /tmp/foo file.":}
 }
 file { "/tmp/foo":
     ensure =&gt; present,
 }
</code></pre>

<p>However, this order requirement refers to parse order only, and ordering of
 resources in the configuration graph (e.g. with <code>before</code> or <code>require</code>) does not
 affect the behavior of <code>defined</code>.</p>

<p>If the future parser is in effect, you may also search using types:</p>

<pre><code> defined(Resource['file','/some/file'])
 defined(File['/some/file'])
 defined(Class['foo'])
</code></pre>

<ul>
  <li>Since 2.7.0</li>
  <li>
    <p>Since 3.6.0 variable reference and future parser types</p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:digest) do |args|
    desc <<EOT
<p>Returns a hash value from a provided string using the digest_algorithm setting from the Puppet config file.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:each) do |args|
    desc <<EOT
<p>Applies a parameterized block to each element in a sequence of selected entries from the first
argument and returns the first argument.</p>

<p>This function takes two mandatory arguments: the first should be an Array or a Hash or something that is
of enumerable type (integer, Integer range, or String), and the second
a parameterized block as produced by the puppet syntax:</p>

<pre><code>  $a.each |$x| { ... }
  each($a) |$x| { ... }
</code></pre>

<p>When the first argument is an Array (or of enumerable type other than Hash), the parameterized block
should define one or two block parameters.
For each application of the block, the next element from the array is selected, and it is passed to
the block if the block has one parameter. If the block has two parameters, the first is the elements
index, and the second the value. The index starts from 0.</p>

<pre><code>  $a.each |$index, $value| { ... }
  each($a) |$index, $value| { ... }
</code></pre>

<p>When the first argument is a Hash, the parameterized block should define one or two parameters.
When one parameter is defined, the iteration is performed with each entry as an array of <code>[key, value]</code>,
and when two parameters are defined the iteration is performed with key and value.</p>

<pre><code>  $a.each |$entry|       { ..."key ${$entry[0]}, value ${$entry[1]}" }
  $a.each |$key, $value| { ..."key ${key}, value ${value}" }
</code></pre>

<p>Example using each:</p>

<pre><code>  [1,2,3].each |$val| { ... }                       # 1, 2, 3
  [5,6,7].each |$index, $val| { ... }               # (0, 5), (1, 6), (2, 7)
  {a=&gt;1, b=&gt;2, c=&gt;3}].each |$val| { ... }           # ['a', 1], ['b', 2], ['c', 3]
  {a=&gt;1, b=&gt;2, c=&gt;3}.each |$key, $val| { ... }      # ('a', 1), ('b', 2), ('c', 3)
  Integer[ 10, 20 ].each |$index, $value| { ... }   # (0, 10), (1, 11) ...
  "hello".each |$char| { ... }                      # 'h', 'e', 'l', 'l', 'o'
  3.each |$number| { ... }                          # 0, 1, 2
</code></pre>

<ul>
  <li>since 3.2 for Array and Hash</li>
  <li>since 3.5 for other enumerables</li>
  <li>
    <p>note requires <code>parser = future</code></p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:emerg) do |args|
    desc <<EOT
<p>Log a message on the server at level emerg.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:epp) do |args|
    desc <<EOT
<p>Evaluates an Embedded Puppet Template (EPP) file and returns the rendered text result as a String.</p>

<p>The first argument to this function should be a <code>&lt;MODULE NAME&gt;/&lt;TEMPLATE FILE&gt;</code>
reference, which will load <code>&lt;TEMPLATE FILE&gt;</code> from a module’s <code>templates</code>
directory. (For example, the reference <code>apache/vhost.conf.epp</code> will load the
file <code>&lt;MODULES DIRECTORY&gt;/apache/templates/vhost.conf.epp</code>.)</p>

<p>The second argument is optional; if present, it should be a hash containing parameters for the
template. (See below.)</p>

<p>EPP supports the following tags:</p>

<ul>
  <li><code>&lt;%= puppet expression %&gt;</code> - This tag renders the value of the expression it contains.</li>
  <li><code>&lt;% puppet expression(s) %&gt;</code> - This tag will execute the expression(s) it contains, but renders nothing.</li>
  <li><code>&lt;%# comment %&gt;</code> - The tag and its content renders nothing.</li>
  <li><code>&lt;%%</code> or <code>%%&gt;</code> - Renders a literal <code>&lt;%</code> or <code>%&gt;</code> respectively.</li>
  <li><code>&lt;%-</code> - Same as <code>&lt;%</code> but suppresses any leading whitespace.</li>
  <li><code>-%&gt;</code> - Same as <code>%&gt;</code> but suppresses any trailing whitespace on the same line (including line break).</li>
  <li><code>&lt;%- |parameters| -%&gt;</code> - When placed as the first tag declares the template’s parameters.</li>
</ul>

<p>File based EPP supports the following visibilities of variables in scope:</p>

<ul>
  <li>Global scope (i.e. top + node scopes) - global scope is always visible</li>
  <li>Global + all given arguments - if the EPP template does not declare parameters, and arguments are given</li>
  <li>Global + declared parameters - if the EPP declares parameters, given argument names must match</li>
</ul>

<p>EPP supports parameters by placing an optional parameter list as the very first element in the EPP. As an example,
<code>&lt;%- |$x, $y, $z = 'unicorn'| -%&gt;</code> when placed first in the EPP text declares that the parameters <code>x</code> and <code>y</code> must be
given as template arguments when calling <code>inline_epp</code>, and that <code>z</code> if not given as a template argument
defaults to <code>'unicorn'</code>. Template parameters are available as variables, e.g.arguments <code>$x</code>, <code>$y</code> and <code>$z</code> in the example.
Note that <code>&lt;%-</code> must be used or any leading whitespace will be interpreted as text</p>

<p>Arguments are passed to the template by calling <code>epp</code> with a Hash as the last argument, where parameters
are bound to values, e.g. <code>epp('...', {'x'=&gt;10, 'y'=&gt;20})</code>. Excess arguments may be given
(i.e. undeclared parameters) only if the EPP templates does not declare any parameters at all.
Template parameters shadow variables in outer scopes. File based epp does never have access to variables in the
scope where the <code>epp</code> function is called from.</p>

<ul>
  <li>See function inline_epp for examples of EPP</li>
  <li>Since 3.5</li>
  <li>
    <p>Requires Future Parser</p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:err) do |args|
    desc <<EOT
<p>Log a message on the server at level err.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:extlookup) do |args|
    desc <<EOT
<p>This is a parser function to read data from external files, this version
uses CSV files but the concept can easily be adjust for databases, yaml
or any other queryable data source.</p>

<p>The object of this is to make it obvious when it’s being used, rather than
magically loading data in when a module is loaded I prefer to look at the code
and see statements like:</p>

<pre><code>$snmp_contact = extlookup("snmp_contact")
</code></pre>

<p>The above snippet will load the snmp_contact value from CSV files, this in its
own is useful but a common construct in puppet manifests is something like this:</p>

<pre><code>case $domain {
  "myclient.com": { $snmp_contact = "John Doe &lt;john@myclient.com&gt;" }
  default:        { $snmp_contact = "My Support &lt;support@my.com&gt;" }
}
</code></pre>

<p>Over time there will be a lot of this kind of thing spread all over your manifests
and adding an additional client involves grepping through manifests to find all the
places where you have constructs like this.</p>

<p>This is a data problem and shouldn’t be handled in code, and using this function you
can do just that.</p>

<p>First you configure it in site.pp:</p>

<pre><code>$extlookup_datadir = "/etc/puppet/manifests/extdata"
$extlookup_precedence = ["%{fqdn}", "domain_%{domain}", "common"]
</code></pre>

<p>The array tells the code how to resolve values, first it will try to find it in
web1.myclient.com.csv then in domain_myclient.com.csv and finally in common.csv</p>

<p>Now create the following data files in /etc/puppet/manifests/extdata:</p>

<pre><code>domain_myclient.com.csv:
  snmp_contact,John Doe &lt;john@myclient.com&gt;
  root_contact,support@%{domain}
  client_trusted_ips,192.168.1.130,192.168.10.0/24

common.csv:
  snmp_contact,My Support &lt;support@my.com&gt;
  root_contact,support@my.com
</code></pre>

<p>Now you can replace the case statement with the simple single line to achieve
the exact same outcome:</p>

<pre><code>$snmp_contact = extlookup("snmp_contact")
</code></pre>

<p>The above code shows some other features, you can use any fact or variable that
is in scope by simply using %{varname} in your data files, you can return arrays
by just having multiple values in the csv after the initial variable name.</p>

<p>In the event that a variable is nowhere to be found a critical error will be raised
that will prevent your manifest from compiling, this is to avoid accidentally putting
in empty values etc.  You can however specify a default value:</p>

<pre><code>$ntp_servers = extlookup("ntp_servers", "1.${country}.pool.ntp.org")
</code></pre>

<p>In this case it will default to “1.${country}.pool.ntp.org” if nothing is defined in
any data file.</p>

<p>You can also specify an additional data file to search first before any others at use
time, for example:</p>

<pre><code>$version = extlookup("rsyslog_version", "present", "packages")
package{"rsyslog": ensure =&gt; $version }
</code></pre>

<p>This will look for a version configured in packages.csv and then in the rest as configured
by $extlookup_precedence if it’s not found anywhere it will default to <code>present</code>, this kind
of use case makes puppet a lot nicer for managing large amounts of packages since you do not
need to edit a load of manifests to do simple things like adjust a desired version number.</p>

<p>Precedence values can have variables embedded in them in the form %{fqdn}, you could for example do:</p>

<pre><code>$extlookup_precedence = ["hosts/%{fqdn}", "common"]
</code></pre>

<p>This will result in /path/to/extdata/hosts/your.box.com.csv being searched.</p>

<p>This is for back compatibility to interpolate variables with %. % interpolation is a workaround for a problem that has been fixed: Puppet variable interpolation at top scope used to only happen on each run.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:fail) do |args|
    desc <<EOT
<p>Fail with a parse error.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:file) do |args|
    desc <<EOT
<p>Loads a file from a module and returns its contents as a string.</p>

<p>The argument to this function should be a <code>&lt;MODULE NAME&gt;/&lt;FILE&gt;</code>
reference, which will load <code>&lt;FILE&gt;</code> from a module’s <code>files</code>
directory. (For example, the reference <code>mysql/mysqltuner.pl</code> will load the
file <code>&lt;MODULES DIRECTORY&gt;/mysql/files/mysqltuner.pl</code>.)</p>

<p>This function can also accept:</p>

<ul>
  <li>An absolute path, which can load a file from anywhere on disk.</li>
  <li>
    <p>Multiple arguments, which will return the contents of the <strong>first</strong> file
found, skipping any files that don’t exist.</p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:filter) do |args|
    desc <<EOT
<p>Applies a parameterized block to each element in a sequence of entries from the first
 argument and returns an array or hash (same type as left operand for array/hash, and array for
 other enumerable types) with the entries for which the block evaluates to <code>true</code>.</p>

<p>This function takes two mandatory arguments: the first should be an Array, a Hash, or an
 Enumerable object (integer, Integer range, or String),
 and the second a parameterized block as produced by the puppet syntax:</p>

<pre><code>   $a.filter |$x| { ... }
   filter($a) |$x| { ... }
</code></pre>

<p>When the first argument is something other than a Hash, the block is called with each entry in turn.
 When the first argument is a Hash the entry is an array with <code>[key, value]</code>.</p>

<p>Example Using filter with one parameter</p>

<pre><code>   # selects all that end with berry
   $a = ["raspberry", "blueberry", "orange"]
   $a.filter |$x| { $x =~ /berry$/ }          # rasberry, blueberry
</code></pre>

<p>If the block defines two parameters, they will be set to <code>index, value</code> (with index starting at 0) for all
 enumerables except Hash, and to <code>key, value</code> for a Hash.</p>

<p>Example Using filter with two parameters</p>

<pre><code> # selects all that end with 'berry' at an even numbered index
 $a = ["raspberry", "blueberry", "orange"]
 $a.filter |$index, $x| { $index % 2 == 0 and $x =~ /berry$/ } # raspberry

 # selects all that end with 'berry' and value &gt;= 1
 $a = {"raspberry"=&gt;0, "blueberry"=&gt;1, "orange"=&gt;1}
 $a.filter |$key, $x| { $x =~ /berry$/ and $x &gt;= 1 } # blueberry
</code></pre>

<ul>
  <li>since 3.4 for Array and Hash</li>
  <li>since 3.5 for other enumerables</li>
  <li>
    <p>note requires <code>parser = future</code></p>
  </li>
  <li><em>Type</em>: statement</li>
</ul>

<h2 id="fqdnrand">fqdn_rand</h2>
<p>Usage: <code>fqdn_rand(MAX, [SEED])</code>. MAX is required and must be a positive
integer; SEED is optional and may be any number or string.</p>

<p>Generates a random whole number greater than or equal to 0 and less than MAX,
combining the <code>$fqdn</code> fact and the value of SEED for repeatable randomness.
(That is, each node will get a different random number from this function, but
a given node’s result will be the same every time unless its hostname changes.)</p>

<p>This function is usually used for spacing out runs of resource-intensive cron
tasks that run on many nodes, which could cause a thundering herd or degrade
other services if they all fire at once. Adding a SEED can be useful when you
have more than one such task and need several unrelated random numbers per
node. (For example, <code>fqdn_rand(30)</code>, <code>fqdn_rand(30, 'expensive job 1')</code>, and
<code>fqdn_rand(30, 'expensive job 2')</code> will produce totally different numbers.)</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:generate) do |args|
    desc <<EOT
<p>Calls an external command on the Puppet master and returns
the results of the command.  Any arguments are passed to the external command as
arguments.  If the generator does not exit with return code of 0,
the generator is considered to have failed and a parse error is
thrown.  Generators can only have file separators, alphanumerics, dashes,
and periods in them.  This function will attempt to protect you from
malicious generator calls (e.g., those with ‘..’ in them), but it can
never be entirely safe.  No subshell is used to execute
generators, so all shell metacharacters are passed directly to
the generator.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:hiera) do |args|
    desc <<EOT
<p>Performs a
standard priority lookup and returns the most specific value for a given key.
The returned value can be data of any type (strings, arrays, or hashes).</p>

<p>In addition to the required <code>key</code> argument, <code>hiera</code> accepts two additional
arguments:</p>

<ul>
  <li>a <code>default</code> argument in the second position, providing a value to be
returned in the absence of matches to the <code>key</code> argument</li>
  <li>an <code>override</code> argument in the third position, providing a data source
to consult for matching values, even if it would not ordinarily be
part of the matched hierarchy. If Hiera doesn’t find a matching key
in the named override data source, it will continue to search through the
rest of the hierarchy.</li>
</ul>

<p>More thorough examples of <code>hiera</code> are available at:
<a href="http://docs.puppetlabs.com/hiera/1/puppet.html#hiera-lookup-functions">http://docs.puppetlabs.com/hiera/1/puppet.html#hiera-lookup-functions</a></p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>

<h2 id="hieraarray">hiera_array</h2>
<p>Returns all
matches throughout the hierarchy — not just the first match — as a flattened array of unique values.
If any of the matched values are arrays, they’re flattened and included in the results.</p>

<p>In addition to the required <code>key</code> argument, <code>hiera_array</code> accepts two additional
arguments:</p>

<ul>
  <li>a <code>default</code> argument in the second position, providing a string or array to be returned
in the absence of  matches to the <code>key</code> argument</li>
  <li>an <code>override</code> argument in the third position, providing a data source to consult for
matching values, even if it would not ordinarily be part of the matched hierarchy.
If Hiera doesn’t find a matching key in the named override data source, it will
continue to search through the rest of the hierarchy.</li>
</ul>

<p>If any matched value is a hash, puppet will raise a type mismatch error.</p>

<p>More thorough examples of <code>hiera</code> are available at:
<a href="http://docs.puppetlabs.com/hiera/1/puppet.html#hiera-lookup-functions">http://docs.puppetlabs.com/hiera/1/puppet.html#hiera-lookup-functions</a></p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>

<h2 id="hierahash">hiera_hash</h2>
<p>Returns a merged hash of matches from throughout the hierarchy. In cases where two or
more hashes share keys, the hierarchy  order determines which key/value pair will be
used in the returned hash, with the pair in the highest priority data source winning.</p>

<p>In addition to the required <code>key</code> argument, <code>hiera_hash</code> accepts two additional
arguments:</p>

<ul>
  <li>a <code>default</code> argument in the second position, providing a  hash to be returned in the
absence of any matches for the <code>key</code> argument</li>
  <li>an <code>override</code> argument in the third position, providing  a data source to insert at
the top of the hierarchy, even if it would not ordinarily match during a Hiera data
source lookup. If Hiera doesn’t find a match in the named override data source, it will
continue to search through the rest of the hierarchy.</li>
</ul>

<p><code>hiera_hash</code> expects that all values returned will be hashes. If any of the values
found in the data sources are strings or arrays, puppet will raise a type mismatch error.</p>

<p>More thorough examples of <code>hiera_hash</code> are available at:
<a href="http://docs.puppetlabs.com/hiera/1/puppet.html#hiera-lookup-functions">http://docs.puppetlabs.com/hiera/1/puppet.html#hiera-lookup-functions</a></p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>

<h2 id="hierainclude">hiera_include</h2>
<p>Assigns classes to a node
using an array merge lookup that retrieves the value for a user-specified key
from a Hiera data source.</p>

<p>To use <code>hiera_include</code>, the following configuration is required:</p>

<ul>
  <li>A key name to use for classes, e.g. <code>classes</code>.</li>
  <li>A line in the puppet <code>sites.pp</code> file (e.g. <code>/etc/puppet/manifests/sites.pp</code>)
reading <code>hiera_include('classes')</code>. Note that this line must be outside any node
definition and below any top-scope variables in use for Hiera lookups.</li>
  <li>
    <p>Class keys in the appropriate data sources. In a data source keyed to a node’s role,
one might have:</p>

    <pre><code>    ---
    classes:
      - apache
      - apache::passenger
</code></pre>
  </li>
</ul>

<p>In addition to the required <code>key</code> argument, <code>hiera_include</code> accepts two additional
arguments:</p>

<ul>
  <li>a <code>default</code> argument in the second position, providing an array to be returned
in the absence of matches to the <code>key</code> argument</li>
  <li>an <code>override</code> argument in the third position, providing a data source to consult
for matching values, even if it would not ordinarily be part of the matched hierarchy.
If Hiera doesn’t find a matching key in the named override data source, it will continue
to search through the rest of the hierarchy.</li>
</ul>

<p>More thorough examples of <code>hiera_include</code> are available at:
<a href="http://docs.puppetlabs.com/hiera/1/puppet.html#hiera-lookup-functions">http://docs.puppetlabs.com/hiera/1/puppet.html#hiera-lookup-functions</a></p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:include) do |args|
    desc <<EOT
<p>Declares one or more classes, causing the resources in them to be
evaluated and added to the catalog. Accepts a class name, an array of class
names, or a comma-separated list of class names.</p>

<p>The <code>include</code> function can be used multiple times on the same class and will
only declare a given class once. If a class declared with <code>include</code> has any
parameters, Puppet will automatically look up values for them in Hiera, using
<code>&lt;class name&gt;::&lt;parameter name&gt;</code> as the lookup key.</p>

<p>Contrast this behavior with resource-like class declarations
(<code>class {'name': parameter =&gt; 'value',}</code>), which must be used in only one place
per class and can directly set parameters. You should avoid using both <code>include</code>
and resource-like declarations with the same class.</p>

<p>The <code>include</code> function does not cause classes to be contained in the class
where they are declared. For that, see the <code>contain</code> function. It also
does not create a dependency relationship between the declared class and the
surrounding class; for that, see the <code>require</code> function.</p>

<p>When the future parser is used, you must use the class’s full name;
relative names are no longer allowed. In addition to names in string form,
you may also directly use Class and Resource Type values that are produced by
the future parser’s resource and relationship expressions.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:info) do |args|
    desc <<EOT
<p>Log a message on the server at level info.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>

<h2 id="inlineepp">inline_epp</h2>
<p>Evaluates an Embedded Puppet Template (EPP) string and returns the rendered text result as a String.</p>

<p>EPP support the following tags:</p>

<ul>
  <li><code>&lt;%= puppet expression %&gt;</code> - This tag renders the value of the expression it contains.</li>
  <li><code>&lt;% puppet expression(s) %&gt;</code> - This tag will execute the expression(s) it contains, but renders nothing.</li>
  <li><code>&lt;%# comment %&gt;</code> - The tag and its content renders nothing.</li>
  <li><code>&lt;%%</code> or <code>%%&gt;</code> - Renders a literal <code>&lt;%</code> or <code>%&gt;</code> respectively.</li>
  <li><code>&lt;%-</code> - Same as <code>&lt;%</code> but suppresses any leading whitespace.</li>
  <li><code>-%&gt;</code> - Same as <code>%&gt;</code> but suppresses any trailing whitespace on the same line (including line break).</li>
  <li><code>&lt;%- |parameters| -%&gt;</code> - When placed as the first tag declares the template’s parameters.</li>
</ul>

<p>Inline EPP supports the following visibilities of variables in scope which depends on how EPP parameters
are used - see further below:</p>

<ul>
  <li>Global scope (i.e. top + node scopes) - global scope is always visible</li>
  <li>Global + Enclosing scope - if the EPP template does not declare parameters, and no arguments are given</li>
  <li>Global + all given arguments - if the EPP template does not declare parameters, and arguments are given</li>
  <li>Global + declared parameters - if the EPP declares parameters, given argument names must match</li>
</ul>

<p>EPP supports parameters by placing an optional parameter list as the very first element in the EPP. As an example,
<code>&lt;%- |$x, $y, $z='unicorn'| -%&gt;</code> when placed first in the EPP text declares that the parameters <code>x</code> and <code>y</code> must be
given as template arguments when calling <code>inline_epp</code>, and that <code>z</code> if not given as a template argument
defaults to <code>'unicorn'</code>. Template parameters are available as variables, e.g.arguments <code>$x</code>, <code>$y</code> and <code>$z</code> in the example.
Note that <code>&lt;%-</code> must be used or any leading whitespace will be interpreted as text</p>

<p>Arguments are passed to the template by calling <code>inline_epp</code> with a Hash as the last argument, where parameters
are bound to values, e.g. <code>inline_epp('...', {'x'=&gt;10, 'y'=&gt;20})</code>. Excess arguments may be given
(i.e. undeclared parameters) only if the EPP templates does not declare any parameters at all.
Template parameters shadow variables in outer scopes.</p>

<p>Note: An inline template is best stated using a single-quoted string, or a heredoc since a double-quoted string
is subject to expression interpolation before the string is parsed as an EPP template. Here are examples
(using heredoc to define the EPP text):</p>

<pre><code># produces 'Hello local variable world!'
$x ='local variable'
inline_epptemplate(@(END:epp))
&lt;%- |$x| -%&gt;
Hello &lt;%= $x %&gt; world!
END

# produces 'Hello given argument world!'
$x ='local variable world'
inline_epptemplate(@(END:epp), { x =&gt;'given argument'})
&lt;%- |$x| -%&gt;
Hello &lt;%= $x %&gt; world!
END

# produces 'Hello given argument world!'
$x ='local variable world'
inline_epptemplate(@(END:epp), { x =&gt;'given argument'})
&lt;%- |$x| -%&gt;
Hello &lt;%= $x %&gt;!
END

# results in error, missing value for y
$x ='local variable world'
inline_epptemplate(@(END:epp), { x =&gt;'given argument'})
&lt;%- |$x, $y| -%&gt;
Hello &lt;%= $x %&gt;!
END

# Produces 'Hello given argument planet'
$x ='local variable world'
inline_epptemplate(@(END:epp), { x =&gt;'given argument'})
&lt;%- |$x, $y=planet| -%&gt;
Hello &lt;%= $x %&gt; &lt;%= $y %&gt;!
END
</code></pre>

<ul>
  <li>Since 3.5</li>
  <li>
    <p>Requires Future Parser</p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>

<h2 id="inlinetemplate">inline_template</h2>
<p>Evaluate a template string and return its value.  See
<a href="http://docs.puppetlabs.com/guides/templating.html">the templating docs</a> for
more information.  Note that if multiple template strings are specified, their
output is all concatenated and returned as the output of the function.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:lookup) do |args|
    desc <<EOT
<p>Looks up data defined using Puppet Bindings and Hiera.
The function is callable with one to three arguments and optionally with a code block to further process the result.</p>

<p>The lookup function can be called in one of these ways:</p>

<pre><code>lookup(name)
lookup(name, type)
lookup(name, type, default)
lookup(options_hash)
lookup(name, options_hash)
</code></pre>

<p>The function may optionally be called with a code block / lambda with the following signatures:</p>

<pre><code>lookup(...) |$result| { ... }
lookup(...) |$name, $result| { ... }
lookup(...) |$name, $result, $default| { ... }
</code></pre>

<p>The longer signatures are useful when the block needs to raise an error (it can report the name), or
if it needs to know if the given default value was selected.</p>

<p>The code block receives the following three arguments:</p>

<ul>
  <li>The <code>$name</code> is the last name that was looked up (<em>the</em> name if only one name was looked up)</li>
  <li>The <code>$result</code> is the looked up value (or the default value if not found).</li>
  <li>The <code>$default</code> is the given default value (<code>undef</code> if not given).</li>
</ul>

<p>The block, if present, is called with the result from the lookup. The value produced by the block is also what is
produced by the <code>lookup</code> function.
When a block is used, it is the users responsibility to call <code>error</code> if the result does not meet additional
criteria, or if an undef value is not acceptable. If a value is not found, and a default has been
specified, the default value is given to the block.</p>

<p>The content of the options hash is:</p>

<ul>
  <li><code>name</code> - The name or array of names to lookup (first found is returned)</li>
  <li><code>type</code> - The type to assert (a Type or a type specification in string form)</li>
  <li><code>default</code> - The default value if there was no value found (must comply with the data type)</li>
  <li><code>accept_undef</code> - (default <code>false</code>) An <code>undef</code> result is accepted if this options is set to <code>true</code>.</li>
  <li><code>override</code> - a hash with map from names to values that are used instead of the underlying bindings. If the name
is found here it wins. Defaults to an empty hash.</li>
  <li><code>extra</code> - a hash with map from names to values that are used as a last resort to obtain a value. Defaults to an
empty hash.</li>
</ul>

<p>When the call is on the form <code>lookup(name, options_hash)</code>, or <code>lookup(name, type, options_hash)</code>, the given name
argument wins over the <code>options_hash['name']</code>.</p>

<p>The search order is <code>override</code> (if given), then <code>binder</code>, then <code>hiera</code> and finally <code>extra</code> (if given). The first to produce
a value other than undef for a given name wins.</p>

<p>The type specification is one of:</p>

<ul>
  <li>A type in the Puppet Type System, e.g.:
    <ul>
      <li><code>Integer</code>, an integral value with optional range e.g.:
        <ul>
          <li><code>Integer[0, default]</code> - 0 or positive</li>
          <li><code>Integer[default, -1]</code> - negative,</li>
          <li><code>Integer[1,100]</code> - value between 1 and 100 inclusive</li>
        </ul>
      </li>
      <li><code>String</code>- any string</li>
      <li><code>Float</code> - floating point number (same signature as for Integer for <code>Integer</code> ranges)</li>
      <li><code>Boolean</code> - true of false (strict)</li>
      <li><code>Array</code> - an array (of Data by default), or parameterized as <code>Array[&lt;element_type&gt;]</code>, where
<code>&lt;element_type&gt;</code> is the expected type of elements</li>
      <li><code>Hash</code>,  - a hash (of default <code>Literal</code> keys and <code>Data</code> values), or parameterized as
<code>Hash[&lt;value_type&gt;]</code>, <code>Hash[&lt;key_type&gt;, &lt;value_type&gt;]</code>, where <code>&lt;key_type&gt;</code>, and
<code>&lt;value_type&gt;</code> are the types of the keys and values respectively
(key is <code>Literal</code> by default).</li>
      <li><code>Data</code> - abstract type representing any <code>Literal</code>, <code>Array[Data]</code>, or <code>Hash[Literal, Data]</code></li>
      <li><code>Pattern[&lt;p1&gt;, &lt;p2&gt;, ..., &lt;pn&gt;]</code> - an enumeration of valid patterns (one or more) where
 a pattern is a regular expression string or regular expression,
 e.g. <code>Pattern['.com$', '.net$']</code>, <code>Pattern[/[a-z]+[0-9]+/]</code></li>
      <li><code>Enum[&lt;s1&gt;, &lt;s2&gt;, ..., &lt;sn&gt;]</code>, - an enumeration of exact string values (one or more)
 e.g. <code>Enum[blue, red, green]</code>.</li>
      <li><code>Variant[&lt;t1&gt;, &lt;t2&gt;,...&lt;tn&gt;]</code> - matches one of the listed types (at least one must be given)
e.g. <code>Variant[Integer[8000,8999], Integer[20000, 99999]]</code> to accept a value in either range</li>
      <li><code>Regexp</code>- a regular expression (i.e. the result is a regular expression, not a string
 matching a regular expression).</li>
    </ul>
  </li>
  <li>A string containing a type description - one of the types as shown above but in string form.</li>
</ul>

<p>If the function is called without specifying a default value, and nothing is bound to the given name
an error is raised unless the option <code>accept_undef</code> is true. If a block is given it must produce an acceptable
value (or call <code>error</code>). If the block does not produce an acceptable value an error is
raised.</p>

<p>Examples:</p>

<p>When called with one argument; <strong>the name</strong>, it
returns the bound value with the given name after having  asserted it has the default datatype <code>Data</code>:</p>

<pre><code>lookup('the_name')
</code></pre>

<p>When called with two arguments; <strong>the name</strong>, and <strong>the expected type</strong>, it
returns the bound value with the given name after having asserted it has the given data
type (‘String’ in the example):</p>

<pre><code>lookup('the_name', 'String') # 3.x
lookup('the_name', String)   # parser future
</code></pre>

<p>When called with three arguments, <strong>the name</strong>, the <strong>expected type</strong>, and a <strong>default</strong>, it
returns the bound value with the given name, or the default after having asserted the value
has the given data type (<code>String</code> in the example above):</p>

<pre><code>lookup('the_name', 'String', 'Fred') # 3x
lookup('the_name', String, 'Fred')   # parser future
</code></pre>

<p>Using a lambda to process the looked up result - asserting that it starts with an upper case letter:</p>

<pre><code># only with parser future
lookup('the_size', Integer[1,100]) |$result| {
  if $large_value_allowed and $result &gt; 10
    { error 'Values larger than 10 are not allowed'}
  $result
}
</code></pre>

<p>Including the name in the error</p>

<pre><code># only with parser future
lookup('the_size', Integer[1,100]) |$name, $result| {
  if $large_value_allowed and $result &gt; 10
    { error 'The bound value for '${name}' can not be larger than 10 in this configuration'}
  $result
}
</code></pre>

<p>When using a block, the value it produces is also asserted against the given type, and it may not be
<code>undef</code> unless the option <code>'accept_undef'</code> is <code>true</code>.</p>

<p>All options work as the corresponding (direct) argument. The <code>first_found</code> option and
<code>accept_undef</code> are however only available as options.</p>

<p>Using first_found semantics option to return the first name that has a bound value:</p>

<pre><code>lookup(['apache::port', 'nginx::port'], 'Integer', 80)
</code></pre>

<p>If you want to make lookup return undef when no value was found instead of raising an error:</p>

<pre><code> $are_you_there = lookup('peekaboo', { accept_undef =&gt; true} )
 $are_you_there = lookup('peekaboo', { accept_undef =&gt; true}) |$result| { $result }
</code></pre>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:map) do |args|
    desc <<EOT
<p>Applies a parameterized block to each element in a sequence of entries from the first
argument and returns an array with the result of each invocation of the parameterized block.</p>

<p>This function takes two mandatory arguments: the first should be an Array, Hash, or of Enumerable type
(integer, Integer range, or String), and the second a parameterized block as produced by the puppet syntax:</p>

<pre><code>  $a.map |$x| { ... }
  map($a) |$x| { ... }
</code></pre>

<p>When the first argument <code>$a</code> is an Array or of enumerable type, the block is called with each entry in turn.
When the first argument is a hash the entry is an array with <code>[key, value]</code>.</p>

<p>Example Using map with two arguments</p>

<pre><code> # Turns hash into array of values
 $a.map |$x|{ $x[1] }

 # Turns hash into array of keys
 $a.map |$x| { $x[0] }
</code></pre>

<p>When using a block with 2 parameters, the element’s index (starting from 0) for an array, and the key for a hash
is given to the block’s first parameter, and the value is given to the block’s second parameter.args.</p>

<p>Example Using map with two arguments</p>

<pre><code> # Turns hash into array of values
 $a.map |$key,$val|{ $val }

 # Turns hash into array of keys
 $a.map |$key,$val|{ $key }
</code></pre>

<ul>
  <li>since 3.4 for Array and Hash</li>
  <li>since 3.5 for other enumerables, and support for blocks with 2 parameters</li>
  <li>
    <p>note requires <code>parser = future</code></p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:match) do |args|
    desc <<EOT
<p>Returns the match result of matching a String or Array[String] with one of:</p>

<ul>
  <li>Regexp</li>
  <li>String - transformed to a Regexp</li>
  <li>Pattern type</li>
  <li>Regexp type</li>
</ul>

<p>Returns An Array with the entire match at index 0, and each subsequent submatch at index 1-n.
If there was no match <code>undef</code> is returned. If the value to match is an Array, a array
with mapped match results is returned.</p>

<p>Example matching:</p>

<p>“abc123”.match(/([a-z]+)[1-9]+/)    # =&gt; [“abc”]
  “abc123”.match(/([a-z]+)([1-9]+)/)  # =&gt; [“abc”, “123”]</p>

<p>See the documentation for “The Puppet Type System” for more information about types.</p>

<ul>
  <li>since 3.7.0</li>
  <li>
    <p>note requires future parser</p>
  </li>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:md5) do |args|
    desc <<EOT
<p>Returns a MD5 hash value from a provided string.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:notice) do |args|
    desc <<EOT
<p>Log a message on the server at level notice.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:realize) do |args|
    desc <<EOT
<p>Make a virtual object real.  This is useful
when you want to know the name of the virtual object and don’t want to
bother with a full collection.  It is slightly faster than a collection,
and, of course, is a bit shorter.  You must pass the object using a
reference; e.g.: <code>realize User[luke]</code>.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:reduce) do |args|
    desc <<EOT
<p>Applies a parameterized block to each element in a sequence of entries from the first
argument (<em>the enumerable</em>) and returns the last result of the invocation of the parameterized block.</p>

<p>This function takes two mandatory arguments: the first should be an Array, Hash, or something of
enumerable type, and the last a parameterized block as produced by the puppet syntax:</p>

<pre><code>  $a.reduce |$memo, $x| { ... }
  reduce($a) |$memo, $x| { ... }
</code></pre>

<p>When the first argument is an Array or someting of an enumerable type, the block is called with each entry in turn.
When the first argument is a hash each entry is converted to an array with <code>[key, value]</code> before being
fed to the block. An optional ‘start memo’ value may be supplied as an argument between the array/hash
and mandatory block.</p>

<pre><code>  $a.reduce(start) |$memo, $x| { ... }
  reduce($a, start) |$memo, $x| { ... }
</code></pre>

<p>If no ‘start memo’ is given, the first invocation of the parameterized block will be given the first and second
elements of the enumeration, and if the enumerable has fewer than 2 elements, the first
element is produced as the result of the reduction without invocation of the block.</p>

<p>On each subsequent invocation, the produced value of the invoked parameterized block is given as the memo in the
next invocation.</p>

<p>Example Using reduce</p>

<pre><code>  # Reduce an array
  $a = [1,2,3]
  $a.reduce |$memo, $entry| { $memo + $entry }
  #=&gt; 6

  # Reduce hash values
  $a = {a =&gt; 1, b =&gt; 2, c =&gt; 3}
  $a.reduce |$memo, $entry| { [sum, $memo[1]+$entry[1]] }
  #=&gt; [sum, 6]

  # reverse a string
  "abc".reduce |$memo, $char| { "$char$memo" }
  #=&gt;"cbe"
</code></pre>

<p>It is possible to provide a starting ‘memo’ as an argument.</p>

<p>Example Using reduce with given start ‘memo’</p>

<pre><code>  # Reduce an array
  $a = [1,2,3]
  $a.reduce(4) |$memo, $entry| { $memo + $entry }
  #=&gt; 10

  # Reduce hash values
  $a = {a =&gt; 1, b =&gt; 2, c =&gt; 3}
  $a.reduce([na, 4]) |$memo, $entry| { [sum, $memo[1]+$entry[1]] }
  #=&gt; [sum, 10]
</code></pre>

<p>Example Using reduce with an Integer range</p>

<pre><code>  Integer[1,4].reduce |$memo, $x| { $memo + $x }
  #=&gt; 10
</code></pre>

<ul>
  <li>since 3.2 for Array and Hash</li>
  <li>since 3.5 for additional enumerable types</li>
  <li>
    <p>note requires <code>parser = future</code>.</p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:regsubst) do |args|
    desc <<EOT

<p>Perform regexp replacement on a string or array of strings.</p>

<ul>
  <li><em>Parameters</em> (in order):
    <ul>
      <li><em>target</em>  The string or array of strings to operate on.  If an array, the replacement will be performed on each of the elements in the array, and the return value will be an array.</li>
      <li><em>regexp</em>  The regular expression matching the target string.  If you want it anchored at the start and or end of the string, you must do that with ^ and $ yourself.</li>
      <li><em>replacement</em>  Replacement string. Can contain backreferences to what was matched using \0 (whole match), \1 (first set of parentheses), and so on.</li>
      <li><em>flags</em>  Optional. String of single letter flags for how the regexp is interpreted:
        <ul>
          <li><em>E</em>         Extended regexps</li>
          <li><em>I</em>         Ignore case in regexps</li>
          <li><em>M</em>         Multiline regexps</li>
          <li><em>G</em>         Global replacement; all occurrences of the regexp in each target string will be replaced.  Without this, only the first occurrence will be replaced.</li>
        </ul>
      </li>
      <li><em>encoding</em>  Optional.  How to handle multibyte characters.  A single-character string with the following values:
        <ul>
          <li><em>N</em>         None</li>
          <li><em>E</em>         EUC</li>
          <li><em>S</em>         SJIS</li>
          <li><em>U</em>         UTF-8</li>
        </ul>
      </li>
    </ul>
  </li>
  <li><em>Examples</em></li>
</ul>

<p>Get the third octet from the node’s IP address:</p>

<pre><code>$i3 = regsubst($ipaddress,'^(\d+)\.(\d+)\.(\d+)\.(\d+)$','\3')
</code></pre>

<p>Put angle brackets around each octet in the node’s IP address:</p>

<pre><code>$x = regsubst($ipaddress, '([0-9]+)', '&lt;\1&gt;', 'G')
</code></pre>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:require) do |args|
    desc <<EOT
<p>Evaluate one or more classes,  adding the required class as a dependency.</p>

<p>The relationship metaparameters work well for specifying relationships
between individual resources, but they can be clumsy for specifying
relationships between classes.  This function is a superset of the
‘include’ function, adding a class relationship so that the requiring
class depends on the required class.</p>

<p>Warning: using require in place of include can lead to unwanted dependency cycles.</p>

<p>For instance the following manifest, with ‘require’ instead of ‘include’ would produce a nasty dependence cycle, because notify imposes a before between File[/foo] and Service[foo]:</p>

<pre><code>class myservice {
  service { foo: ensure =&gt; running }
}

class otherstuff {
  include myservice
  file { '/foo': notify =&gt; Service[foo] }
}
</code></pre>

<p>Note that this function only works with clients 0.25 and later, and it will
fail if used with earlier clients.</p>

<p>When the future parser is used, you must use the class’s full name;
relative names are no longer allowed. In addition to names in string form,
you may also directly use Class and Resource Type values that are produced by
the future parser’s resource and relationship expressions.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:scanf) do |args|
    desc <<EOT
<p>Scans a string and returns an array of one or more converted values as directed by a given format string.args
See the documenation of Ruby’s String::scanf method for details about the supported formats (which
are similar but not identical to the formats used in Puppet’s <code>sprintf</code> function.</p>

<p>This function takes two mandatory arguments: the first is the String to convert, and the second
the format String. A parameterized block may optionally be given, which is called with the result
that is produced by scanf if no block is present, the result of the block is then returned by
the function.</p>

<p>The result of the scan is an Array, with each sucessfully scanned and transformed value.args The scanning
stops if a scan is unsuccesful and the scanned result up to that point is returned. If there was no
succesful scan at all, the result is an empty Array. The optional code block is typically used to
assert that the scan was succesful, and either produce the same input, or perform unwrapping of
the result</p>

<pre><code>  "42".scanf("%i")
  "42".scanf("%i") |$x| {
    unless $x[0] =~ Integer {
      fail "Expected a well formed integer value, got '$x[0]'"
    }
    $x[0]
  }
</code></pre>

<ul>
  <li>since 3.7.4</li>
  <li>
    <p>note requires <code>parser = future</code></p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:search) do |args|
    desc <<EOT
<p>Add another namespace for this class to search.
This allows you to create classes with sets of definitions and add
those classes to another class’s search path.</p>

<p>Deprecated in Puppet 3.7.0, to be removed in Puppet 4.0.0.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:sha1) do |args|
    desc <<EOT
<p>Returns a SHA1 hash value from a provided string.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:shellquote) do |args|
    desc <<EOT
<p>Quote and concatenate arguments for use in Bourne shell.</p>

<p>Each argument is quoted separately, and then all are concatenated
with spaces.  If an argument is an array, the elements of that
array is interpolated within the rest of the arguments; this makes
it possible to have an array of arguments and pass that array to
shellquote instead of having to specify each argument
individually in the call.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:slice) do |args|
    desc <<EOT
<p>Applies a parameterized block to each <em>slice</em> of elements in a sequence of selected entries from the first
argument and returns the first argument, or if no block is given returns a new array with a concatenation of
the slices.</p>

<p>This function takes two mandatory arguments: the first, <code>$a</code>, should be an Array, Hash, or something of
enumerable type (integer, Integer range, or String), and the second, <code>$n</code>, the number of elements to include
in each slice. The optional third argument should be a a parameterized block as produced by the puppet syntax:</p>

<pre><code>$a.slice($n) |$x| { ... }
slice($a) |$x| { ... }
</code></pre>

<p>The parameterized block should have either one parameter (receiving an array with the slice), or the same number
of parameters as specified by the slice size (each parameter receiving its part of the slice).
In case there are fewer remaining elements than the slice size for the last slice it will contain the remaining
elements. When the block has multiple parameters, excess parameters are set to undef for an array or
enumerable type, and to empty arrays for a Hash.</p>

<pre><code>$a.slice(2) |$first, $second| { ... }
</code></pre>

<p>When the first argument is a Hash, each <code>key,value</code> entry is counted as one, e.g, a slice size of 2 will produce
an array of two arrays with key, and value.</p>

<p>Example Using slice with Hash</p>

<pre><code>$a.slice(2) |$entry|          { notice "first ${$entry[0]}, second ${$entry[1]}" }
$a.slice(2) |$first, $second| { notice "first ${first}, second ${second}" }
</code></pre>

<p>When called without a block, the function produces a concatenated result of the slices.</p>

<p>Example Using slice without a block</p>

<pre><code>slice([1,2,3,4,5,6], 2) # produces [[1,2], [3,4], [5,6]]
slice(Integer[1,6], 2)  # produces [[1,2], [3,4], [5,6]]
slice(4,2)              # produces [[0,1], [2,3]]
slice('hello',2)        # produces [[h, e], [l, l], [o]]
</code></pre>

<ul>
  <li>since 3.2 for Array and Hash</li>
  <li>since 3.5 for additional enumerable types</li>
  <li>
    <p>note requires <code>parser = future</code>.</p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:split) do |args|
    desc <<EOT
<p>Split a string variable into an array using the specified split regexp.</p>

<p><em>Example:</em></p>

<pre><code>$string     = 'v1.v2:v3.v4'
$array_var1 = split($string, ':')
$array_var2 = split($string, '[.]')
$array_var3 = split($string, '[.:]')
</code></pre>

<p><code>$array_var1</code> now holds the result <code>['v1.v2', 'v3.v4']</code>,
while <code>$array_var2</code> holds <code>['v1', 'v2:v3', 'v4']</code>, and
<code>$array_var3</code> holds <code>['v1', 'v2', 'v3', 'v4']</code>.</p>

<p>Note that in the second example, we split on a literal string that contains
a regexp meta-character (.), which must be escaped.  A simple
way to do that for a single character is to enclose it in square
brackets; a backslash will also escape a single character.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:sprintf) do |args|
    desc <<EOT
<p>Perform printf-style formatting of text.</p>

<p>The first parameter is format string describing how the rest of the parameters should be formatted.  See the documentation for the <code>Kernel::sprintf</code> function in Ruby for all the details.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:tag) do |args|
    desc <<EOT
<p>Add the specified tags to the containing class
or definition.  All contained objects will then acquire that tag, also.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:tagged) do |args|
    desc <<EOT
<p>A boolean function that
tells you whether the current container is tagged with the specified tags.
The tags are ANDed, so that all of the specified tags must be included for
the function to return true.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:template) do |args|
    desc <<EOT
<p>Loads an ERB template from a module, evaluates it, and returns the resulting
value as a string.</p>

<p>The argument to this function should be a <code>&lt;MODULE NAME&gt;/&lt;TEMPLATE FILE&gt;</code>
reference, which will load <code>&lt;TEMPLATE FILE&gt;</code> from a module’s <code>templates</code>
directory. (For example, the reference <code>apache/vhost.conf.erb</code> will load the
file <code>&lt;MODULES DIRECTORY&gt;/apache/templates/vhost.conf.erb</code>.)</p>

<p>This function can also accept:</p>

<ul>
  <li>An absolute path, which can load a template file from anywhere on disk.</li>
  <li>
    <p>Multiple arguments, which will evaluate all of the specified templates and
return their outputs concatenated into a single string.</p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:versioncmp) do |args|
    desc <<EOT
<p>Compares two version numbers.</p>

<p>Prototype:</p>

<pre><code>$result = versioncmp(a, b)
</code></pre>

<p>Where a and b are arbitrary version strings.</p>

<p>This function returns:</p>

<ul>
  <li><code>1</code> if version a is greater than version b</li>
  <li><code>0</code> if the versions are equal</li>
  <li><code>-1</code> if version a is less than version b</li>
</ul>

<p>Example:</p>

<pre><code>if versioncmp('2.6-1', '2.4.5') &gt; 0 {
    notice('2.6-1 is &gt; than 2.4.5')
}
</code></pre>

<p>This function uses the same version comparison algorithm used by Puppet’s
<code>package</code> type.</p>

<ul>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

  newfunction(:warning) do |args|
    desc <<EOT
<p>Log a message on the server at level warning.</p>

<ul>
  <li><em>Type</em>: statement</li>
</ul>


EOT
  end

  newfunction(:with) do |args|
    desc <<EOT
<p>Call a lambda code block with the given arguments. Since the parameters of the lambda
are local to the lambda’s scope, this can be used to create private sections
of logic in a class so that the variables are not visible outside of the
class.</p>

<p>Example:</p>

<pre><code> # notices the array [1, 2, 'foo']
 with(1, 2, 'foo') |$x, $y, $z| { notice [$x, $y, $z] }
</code></pre>

<ul>
  <li>since 3.7.0</li>
  <li>
    <p>note requires future parser</p>
  </li>
  <li><em>Type</em>: rvalue</li>
</ul>


EOT
  end

end
