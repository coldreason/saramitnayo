def custom_https_get(url,data=None,method="GET"):
    import usocket
    import ussl
    proto, dummy, host, path = url.split("/", 3)
    port = 443

    ai = usocket.getaddrinfo(host, port, 0, usocket.SOCK_STREAM)
    ai = ai[0]
    s = usocket.socket(ai[0], ai[1], ai[2])
    s.connect(ai[-1])
    s = ussl.wrap_socket(s)

    if data is not None:
        method = "POST"

    s.write(("%s /%s HTTP/1.0\r\n" % (method, path)).encode())
    s.write(("Host: %s\r\n" % host).encode())
    if data:
        s.write(("Content-Type: application/json\r\nContent-Length: %s\r\n\r\n" % str(len(data))).encode())
        s.write(bytes(data,'utf-8'))
    else:
        s.write("\r\n\r\n".encode())
    l = s.readline()
    if len(l) < 2:
        # Invalid response
        raise ValueError("HTTP error: BadStatusLine:\n%s" % l)
    l = l.split(None, 2)
    status = int(l[1])
    ret = ''
    while True:
        l = s.readline()
        if not l:
            break
        ret = l
    s.close()
    return ret