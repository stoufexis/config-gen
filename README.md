A tool that generates configuration from a template

* A template is any file with the first line being a declaration of placeholders to be used in the rest of the file.
* The decleration starts with an exclamation mark followed by a comma seperated list of placeholders.
* To preserve linting on template files using a formal configuration language, the decleration can be placed in a comment.

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

Now, the following command:
```
docker run --rm -it \
  -v $PWD:/opt/templates/ \
  stefanostouf/ldap-new-user \
  template.ldif useruid name surname example com
```

will print:
```
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
