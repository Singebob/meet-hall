import helmet from "koa-helmet";
import cors from "@koa/cors";
import Koa from "koa";

export const initUtilMiddlewares = (app: Koa<Koa.DefaultState, Koa.DefaultContext>) => {
    app.use(helmet());
    app.use(cors());
}