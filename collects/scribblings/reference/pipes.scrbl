#reader(lib "docreader.ss" "scribble")
@require["mz.ss"]

@title[#:tag "mz:pipeports"]{Pipes}

A Scheme @deftech{pipe} is internal to Scheme, and not related to
OS-level pipes (which are @tech{file-stream ports}) for communicating
between different processes.

@defproc[(make-pipe [limit positive-exact-integer? #f]
                    [input-name any/c 'pipe]
                    [output-name any/c 'pipe])
         any]{

Returns two port values: the first port is an input port and the
second is an output port. Data written to the output port is read from
the input port, with no intermediate buffering. The ports do not need
to be explicitly closed.

If @scheme[limit] is @scheme[#f], the new pipe holds an unlimited
number of unread bytes (i.e., limited only by the available
memory). If @scheme[limit] is a positive number, then the pipe will
hold at most @scheme[limit] unread/unpeeked bytes; writing to the
pipe's output port thereafter will block until a read or peek from the
input port makes more space available. (Peeks effectively extend the
port's capacity until the peeked bytes are read.)

The optional @scheme[input-name] and @scheme[output-name] are used
as the names for the returned input and out ports, respectively.}

@defproc[(pipe-content-length [pipe-port port?]) any]{

Returns the number of bytes contained in a pipe, where
@scheme[pipe-port] is either of the pipe's ports produced by
@scheme[make-pipe]. The pipe's content length counts all bytes that
have been written to the pipe and not yet read (though possibly
peeked).}
