I was recently contacted by a client inquiring how to forward a user's mail using MPS.  There is no specific 
"provider method" for this, but it is actually very easy using the `Managed Active Directory::ModifyUser` method. 

To enable forwarding, there are really only two properties that we need to be concerned about: `altRecipient` and 
`deliverAndRedirect`.  `altRecipient` should be set to the DN of a mail-enabled object within the directory and 
`deliverAndRedirect` is a Boolean that should be set to indicate if the mail should be delivered to the local mailbox 
as well as being forwarded or just to simply forward the mail.

The `executeData` blob of the `ModifyUser` method should look something like the following:

    <executeData>
        <user/>
        <properties>
            <property name="altRecipient"></property>
            <property name="deliverAndRedirect">
                <value xmlns:dt='urn:schemas-microsoft-com:datatypes' dt:dt='boolean'/>
            </property>
        </properties>
    </executeData>

The tags have been discussed previously with the exception of the `<user/>` tag which should contain the LDAP path to 
the user object to be modified.
