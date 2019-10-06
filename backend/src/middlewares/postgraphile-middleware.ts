import postgraphile from "postgraphile";
import Koa from "koa";
import { initPostgraphile } from "../postgraphile/init-postgraphile";

export const initPostGraphileMiddleware = (
  app: Koa<Koa.DefaultState, Koa.DefaultContext>
) => {
  app.use((ctx, next) => {
    // PostGraphile deals with (req, res) but we want access to sessions from `pgSettings`, so we make the ctx available on req.
    Object.assign(ctx.req, ctx);
    return next();
  });
  const { connection, schema, options } = initPostgraphile().library;
  app.use(
    postgraphile(connection, schema, {
      // Import our shared options
      ...options,

      // Since we're using sessions we'll also want our login plugin
      appendPlugins: [
        // All the plugins in our shared config
        ...(options.appendPlugins || [])
      ]

      // Given a request object, returns the settings to set within the
      // Postgres transaction used by GraphQL.
      // pgSettings(req) {
      //   return {
      //     role: "graphiledemo_visitor",
      //     "jwt.claims.user_id": req.ctx.state.user && req.ctx.state.user.id,
      //   };
      // },
    })
  );
};
