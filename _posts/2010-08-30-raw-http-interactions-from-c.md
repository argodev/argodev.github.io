---
layout: post
category: technology
title: 'Raw HTTP Interactions from C#'
date: 2010-08-30 00:00
tags:
- general development
- .net
- samples
redirect_from:
- /blog/2010/8/30/raw-http-interactions-from-c.html
---


I had a conversation with a friend last week who was messing around with a non-SOAP based HTTP service and was fighting
with the C# necessary for rudimentary interactions. The problem was compounded by the fact that he needed to associate
a certificate with the request to authenticate properly to the server.

I had recently been doing this exact thing based on some work with the Azure management API so I promised him some
samples. As I was assembling them this morning, I decided to drop them here in case they could be beneficial to others.

The first sample shows a simple call wherein I build some XML and send it along with the request. In this case we are
creating a deployment in Windows Azure. We then grab a value from the response header collection for use in the second
call that has a simple request format but returns an XML blob in the body that I then parse to get the results I need.

Both requests are signed with an X509 client certificate – you’ll notice it referred to as “managementCertificate” –
this is a variable passed in that was generated using the following code:

    var managementCertificate = new X509Certificate2(manifest.CertificateFile);

Where `manifest.CertificateFile` is the path to the pem file on my local machine.

In the sample below, you’ll see the target URL built, some base64 encoding of some of the parameters (included just for
completeness but just a requirement of the service I was calling). I then use a StringBuilder to build up an XML block
and then setup the request with the certificate, xml blob, and other properties set. Finally, you’ll see the
submission and then pulling a value from the headers collection to be sent back to the caller.


    // Build uri string
    // format:https://management.core.windows.net/<subscription-id>/services/
    //                hostedservices/<service-name>/deploymentslots/
    //                <deployment-slot-name>
    var url = string.Format(
        "{0}{1}/services/hostedservices/{2}/deploymentslots/{3}",
        Constants.AzureManagementUrlBase,
        subscriptionId,
        serviceName,
        deploymentSlot);

    // Base64 encode configuration label and file
    var base64label = EncodeAsciiStringTo64(configurationLabel);
    var base64config = GetSettings(
        instanceCount,
        accountName,
        accountKey,
        queueSleepTime,
        maxJobLength,
        container,
        queueName);

    // build request body
    StringBuilder blob = new StringBuilder();
    blob.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
    blob.Append("<CreateDeployment " +
        "xmlns=\"http://schemas.microsoft.com/windowsazure\">\n");
    blob.AppendFormat("\t<Name>{0}</Name>\n", deploymentName);
    blob.AppendFormat("\t<PackageUrl>{0}</PackageUrl>\n", packageUrl);
    blob.AppendFormat("\t<Label>{0}</Label>\n", base64label);
    blob.AppendFormat("\t<Configuration>{0}</Configuration>\n", base64config);
    blob.Append("</CreateDeployment>\n");

    // encode request body then put it in a byte array
    byte[] byteArray = Encoding.UTF8.GetBytes(blob.ToString());

    // make request
    HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);

    // header info
    request.Method = "POST";
    request.ClientCertificates.Add(managementCertificate);
    request.Headers.Add(Constants.VersionHeader, Constants.VersionTarget);
    request.ContentType = Constants.ContentTypeXml;
    request.ContentLength = byteArray.Length;

    Stream dataStream = request.GetRequestStream();

    // write the data to the request stream.
    dataStream.Write(byteArray, 0, byteArray.Length);

    // Get the response.
    HttpWebResponse response = (HttpWebResponse)request.GetResponse();

    // Get the x-ms-requestID
    string requestID = response.GetResponseHeader(Constants.RequestIdHeader);

    // Clean up the streams
    dataStream.Close();
    response.Close();

    return requestID;


In this next sample, we make a rather simple request but do more with the result in parsing the returned XML blob
which is fairly trivial although it does have custom namespaces which have to be accounted for when you crawl the
XML tree.




    // Build uri string
    // format:https://management.core.windows.net/<subscription-id>/services
    //          /hostedservices/<service-name>/deploymentslots
    //          /<deployment-name/
    var url = string.Format(
        "{0}{1}/services/hostedservices/{2}/deploymentslots/{3}",
        Constants.AzureManagementUrlBase,
        subscriptionId,
        serviceName,
        deploymentSlot.ToString());

    // make uri request using created uri string
    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);

    // make header, method, and certificated requests
    request.Method = "GET";
    request.ClientCertificates.Add(managementCertificate);
    request.Headers.Add(Constants.VersionHeader, Constants.VersionTarget);
    request.ContentType = Constants.ContentTypeXml;

    // Get the response
    HttpWebResponse response = (HttpWebResponse)request.GetResponse();

    // put response into string text
    StreamReader dataStream = new StreamReader(response.GetResponseStream());
    string text = dataStream.ReadToEnd();

    // create an xml document
    XmlDocument xml = new XmlDocument();

    // load up the response text as xml
    xml.LoadXml(text);

    // get the NS manager
    XmlNamespaceManager ns = new XmlNamespaceManager(xml.NameTable);
    ns.AddNamespace("az", Constants.AzureXmlNamespace);

    // return the status
    DeploymentStatus currentStatus;
    var statusText = xml.SelectSingleNode("//az:Status", ns).InnerText;

    if (Enum.TryParse<DeploymentStatus>(statusText, true, out currentStatus))
    {
        FullDeploymentStatus fullStatus = new FullDeploymentStatus()
            { MainStatus = currentStatus };

        // now try to get the status values for each instance
        XmlNodeList instances = xml.SelectNodes("//az:RoleInstance", ns);

        foreach (XmlNode instance in instances)
        {
            var instanceStatus = new InstanceDetails()
            {
                RoleName =
                    instance.SelectSingleNode("az:RoleName", ns).InnerText,
                InstanceName =
                    instance.SelectSingleNode("az:InstanceName", ns).InnerText,
                Status = (InstanceStatus)Enum.Parse(typeof(InstanceStatus),
                    instance.SelectSingleNode("az:InstanceStatus", ns).InnerText)
            };

            fullStatus.Instances.Add(instanceStatus);
        }

        return fullStatus;
    }
    else
    {
        throw new ArgumentOutOfRangeException("Status",
            "The status returned for the deployment is outside the range of " +
            "acceptable values");
    }


That is about it. Hopefully this is helpful and give you more comfort interacting with HTTP-based services that aren’t
simply a matter of pointing at a WSDL and having magic happen.
