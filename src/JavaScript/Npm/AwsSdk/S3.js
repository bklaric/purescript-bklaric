import { PutObjectCommand, S3Client } from "@aws-sdk/client-s3"

export const newClient = (config) => () => new S3Client(config)

export const putObject = (params) => (client) => () =>
    client
        .send(new PutObjectCommand({
            Bucket: params.bucket,
            Key: params.key,
            Body: params.body,
            ContentType: params.contentType,
        }))
        // The command's response carries etags and version ids nothing
        // here reads, so it is dropped rather than typed.
        .then(function () { })
