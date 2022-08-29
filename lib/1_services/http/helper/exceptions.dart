class AppExceptions implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppExceptions([this.message, this.prefix, this.url]);
}

/// App exceptions are based on StatusCode of response from API calls
/// based on these exceptions I can easily debug the app while working remotely from the backEnd Developer
/// and also I can show the user of the app different messages in form of SnackBars/Toasts/DialogBoxes etc.. with
/// proper information
// for different cases of status codes here are some common scenarios :

// in case out httpClient throws a SocketException
class NoConnectionException extends AppExceptions {
  NoConnectionException([String? message, String? url]) : super(message, "Unable to process, Check Connection.", url);
}

// In case of timeOut that we ourself set
// OR
// code: 504 GatewayTimedOut
// The problem is the API server’s slow response
class ApiNotRespondingException extends AppExceptions {
  ApiNotRespondingException([String? message, String? url]) : super(message, "API not responding", url);
}

// code: 400 BadRequest
//  It implies that you did not correctly format your API request. You could be missing a query, a field in the request
//  body, or a header field could be wrong. It could also be that some of your request data might have incorrect syntax.
class BadRequestException extends AppExceptions {
  BadRequestException([String? message, String? url]) : super(message, "Bad Request", url);
}

// code: 401 Unauthorized
// This status code means you haven’t yet authenticated against the API. The API doesn’t know who you are and it
// won’t serve you.
class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message, String? url]) : super(message, "UnAuthorised Request", url);
}

// code: 403 Forbidden
// The forbidden status indicates that you don’t have permission to request that URL. You’re authenticated, but the user
// or role you’re authenticated for isn’t permitted to make the API request. This also occurs when you have an
// authentication issue, like when using the wrong API key or trying to access features your subscription plan doesn’t
// allow for.

// code: 404 NotFound
// This is by far the most common HTTP status code you can get. It indicates that the URL you used in your request
// does not exist on the API server, or origin server. Sometimes API URL paths change after a version update, but
// sometimes they change because something on the server went wrong.
class NotFoundException extends AppExceptions {
  NotFoundException([String? message, String? url])
      : super(message, "The resource you are trying to access cannot be found.", url);
}

// code: 500 Internal Server Error
// This HTTP status code can mean anything really, but it usually indicates the API server crashed. It could have been
// caused by something related to your API call

// code: 501 Not Implemented
// The 501 Not Implemented status code is related to the HTTP method you used to request an URL. You can try a different
// HTTP method to make the request

// code: 502 BadGateway
// This response tells you that the server you were calling wasn’t the actual API server, but a gateway or proxy.
// The proxy server tries to call the API server in your name. This error response also indicates that the API server
// did not answer. This could be related to a network problem, or simply because the API server crashed, or was down
// for maintenance.

// code: 503 Service Unavailable
// The 503 Service Unavailable Status indicates a server error. Too many API requests were sent and now the API can’t
// handle any more of them. This problem solves itself when clients send fewer future requests, but it could also mean
// that the API provider did not planned enough resources for all of its customers.
class ServiceUnavailable extends AppExceptions {
  ServiceUnavailable([String? message, String? url]) : super(message, "Unable to process", url);
}

/// misc
class UnKnownException extends AppExceptions {
  UnKnownException([String? message, String? url]) : super(message, "Unknown Error :(.", url);
}
