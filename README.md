A tool that generates configuration from a template.

* A template is any file with the first line being a declaration of placeholders to be used in the rest of the file.
* The decleration starts with an exclamation mark followed by a comma seperated list of placeholders.
* To preserve linting on template files, the decleration can be placed in a comment.

For example, template.ldif could look like this.
```ldif
# !?uid,?n,?sn,?dom,?tld
dn: uid=?uid,ou=users,dc=?dom,dc=?tld
objectclass: top
objectclass: person
objectclass: organizationalPerson
uid: ?uid
givenName: ?n
sn: ?sn
cn: ?uid
mail: ?uid@?dom.?tld
```

Now, the following command (using docker):
```ldif
docker run --rm -it \
  -v $PWD:/opt/templates/ \
  stefanostouf/ldap-new-user \
  template.ldif:useruid,name,surname,example,com:output.ldif
```

will create output.ldif
```ldif
dn: uid=useruid,ou=users,dc=example,dc=com
objectclass: top
objectclass: person
objectclass: organizationalPerson
uid: useruid
givenName: name
sn: surname
cn: useruid
mail: useruid@example.com
```

You can provide more than one arguments seperated with a space. The following
```ldif
docker run --rm -it -v $PWD:/opt/templates/ stefanostouf/config-gen \
  temp.ldif:useruid,name,surname,example,com:output.ldif \
  temp.ldif:useruid2,name2,surname2,example,com:output2.ldif \
  ...
```

will create:

```ldif
# output.ldif

dn: uid=useruid,ou=users,dc=example,dc=com
objectclass: top
objectclass: person
objectclass: organizationalPerson
uid: useruid
givenName: name
sn: surname
cn: useruid
mail: useruid@example.com

# output2.ldif

dn: uid=useruid2,ou=users,dc=example,dc=com
objectclass: top
objectclass: person
objectclass: organizationalPerson
uid: useruid2
givenName: name2
sn: surname2
cn: useruid2
mail: useruid2@example.com

....

```

If you intend to use the same template for sequential arguments, the template can be omitted until you need to specify a different one. E.g.
```ldif
docker run --rm -it -v $PWD:/opt/templates/ stefanostouf/config-gen \
  temp.ldif:useruid,name,surname,example,com:output.ldif \
  :useruid2,name2,surname2,example,com:output2.ldif \
  :useruid3,name3,surname3,example,com:output3.ldif \
  template2.ldif:useruid,name,surname,example,com:output4.ldif \
  ...
```


The docker image can be found at https://hub.docker.com/repository/docker/stefanostouf/config-gen
