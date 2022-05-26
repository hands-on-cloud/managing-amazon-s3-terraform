const AWS = require("aws-sdk");

//initiliaze the AWS S3 SDK
const s3 = new AWS.S3();

exports.handler = async (event) => {
	//get the bucket and key name from the event
	const Bucket = event.Records[0].s3.bucket.name;
	const Key = decodeURIComponent(
		event.Records[0].s3.object.key.replace(/\+/g, " ")
	);

	const params = { Bucket, Key };

	try {
		//read file content from s3:
		const data = await s3.getObject(params).promise();
		//parse the file content to JSON:
		const parsedData = JSON.parse(data.Body.toString());

		//return the parsed data:
		return parsedData;
	} catch (err) {
		console.error("Error in reading s3 file content", err);
		return;
	}
};
