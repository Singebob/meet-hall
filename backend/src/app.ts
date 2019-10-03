// Example koa server with postgraphile here: https://github.com/graphile/examples/tree/master/server-koa2 , this still needs completion
import Koa from "koa";
import { AddressInfo } from "net";

const getServerPort = (address: string | AddressInfo | null) =>
  address && typeof address !== "string"
    ? address.port
    : new Error("Oops, we couldn't find the port");

const app = new Koa();
const server = app.listen(3000); // use env variables later
const address = server.address();
console.log(`Server succesfuly started on port ${getServerPort(address)}`);
