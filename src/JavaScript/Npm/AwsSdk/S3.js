import { PutObjectCommand, S3Client } from "@aws-sdk/client-s3"

export function newClient(config) {
    return function () {
        return new S3Client(config)
    }
}

export function putObject(params) {
    return function (client) {
        return function () {
            return client
                .send(new PutObjectCommand({
                    Bucket: params.bucket,
                    Key: params.key,
                    Body: params.body,
                    ContentType: params.contentType,
                }))
                // The command's response carries etags and version ids nothing
                // here reads, so it is dropped rather than typed.
                .then(function () { })
        }
    }
}
