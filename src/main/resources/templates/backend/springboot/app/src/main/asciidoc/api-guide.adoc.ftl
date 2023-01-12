= RESTful Service API Guide
Wolf359;
:doctype: book
:icons: font
:source-highlighter: highlightjs
:toc: left
:toclevels: 4
:sectlinks:
:operation-curl-request-title: Example request
:operation-http-response-title: Example response

<#list entities as entity>

[[${ entity.name.singular }_overview]]
= Overview

Overview of ${ entity.name.singular.pascal }

[[${ entity.name.singular }_overview_http_verbs]]
== HTTP verbs

RESTful ${ entity.name.plural.words.pascal } tries to adhere as closely as possible to standard HTTP and REST conventions in its
use of HTTP verbs.

|===
| Verb | Usage

| `GET`
| Used to retrieve a resource

| `POST`
| Used to create a new resource

| `PATCH`
| Used to update an existing resource, including partial updates

| `DELETE`
| Used to delete an existing resource
|===

[[${ entity.name.singular }_overview_http_status_codes]]
== HTTP status codes

RESTful ${ entity.name.plural.kebab.pascal } tries to adhere as closely as possible to standard HTTP and REST conventions in its
use of HTTP status codes.

|===
| Status code | Usage

| `200 OK`
| The request completed successfully

| `201 Created`
| A new resource has been created successfully. The resource's URI is available from the response's
`Location` header

| `204 No Content`
| An update to an existing resource has been applied successfully

| `400 Bad Request`
| The request was malformed. The response body will include an error providing further information

| `404 Not Found`
| The requested resource did not exist
|===

[[${ entity.name.singular }_overview_errors]]
== Errors

Whenever an error response (status code >= 400) is returned, the body will contain a JSON object
that describes the problem. The error object has the following structure:

//include::{snippets}/error-example/response-fields.adoc[]

For example, a request that attempts to apply a non-existent tag to a ${ entity.name.singular } will produce a
`400 Bad Request` response:

//include::{snippets}/error-example/http-response.adoc[]

[[${ entity.name.singular }_overview_hypermedia]]
== Hypermedia

RESTful ${ entity.name.plural.pascal } uses hypermedia and resources include links to other resources in their
responses. Responses are in https://github.com/mikekelly/hal_specification[Hypertext
Application Language (HAL)] format. Links can be found beneath the `_links` key. Users of
the API should not create URIs themselves, instead they should use the above-described
links to navigate from resource to resource.

[[${ entity.name.singular }_resources]]
= Resources

[[${ entity.name.singular }_resources_${ entity.name.plural }]]
== ${ entity.name.plural.pascal }

The ${ entity.name.singular.pascal } resources is used to create and list ${ entity.name.plural }

[[${ entity.name.singular }_resources_list]]
=== List ${ entity.name.plural.pascal }

A `GET` request will list all the service's ${ entity.name.plural }.

operation::${ entity.name.singular }-controller-test/get-all[snippets='curl-request,http-request,http-response,httpie-request,request-body,response-body']

=== Get One ${ entity.name.singular.pascal }

A `GET` request will retrieve one ${ entity.name.singular }.

operation::${ entity.name.singular }-controller-test/get-one[snippets='curl-request,http-request,http-response,httpie-request,request-body,response-body,response-fields']

=== Create One ${ entity.name.singular.pascal }

A `POST` request will create and return one ${ entity.name.singular }.

operation::${ entity.name.singular }-controller-test/create-one[snippets='curl-request,http-request,http-response,httpie-request,request-body,response-body']

=== Update One ${ entity.name.singular.pascal }

A `PUT` request will update and return one ${ entity.name.singular }.

operation::${ entity.name.singular }-controller-test/update-one[snippets='curl-request,http-request,http-response,httpie-request,request-body,response-body']

=== Patch One ${ entity.name.singular.pascal }

A `PATCH` request will partially update and return one ${ entity.name.singular }.

operation::${ entity.name.singular }-controller-test/patch-one[snippets='curl-request,http-request,http-response,httpie-request,request-body,response-body']

=== Delete One ${ entity.name.singular.pascal }

A `DELETE` request will delete one ${ entity.name.singular }.

operation::${ entity.name.singular }-controller-test/delete-one[snippets='curl-request,http-request,http-response,httpie-request,request-body,response-body']

</#list>