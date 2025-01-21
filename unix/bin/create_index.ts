#!/usr/bin/env bun
import { lstatSync } from "node:fs";
import { readdir, writeFile } from "node:fs/promises";

async function main() {
	const dir = process.argv[2].replace(/\/$/, "");
	if (!dir) {
		throw new Error("No directory provided");
	}
	if (!lstatSync(dir).isDirectory()) {
		throw new Error("Provided path is not a directory");
	}

	const files = await readdir(dir);
	const content = files
		.map((file) => file.split(".")[0])
		.filter((name) => name !== "index")
		.map((name) => `export { ${name} } from './${name}'`)
		.join("\n");

	await writeFile(`${dir}/index.ts`, content);
}

await main();
