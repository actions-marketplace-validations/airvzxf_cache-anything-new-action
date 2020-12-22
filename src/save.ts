import * as cache from "@actions/cache";
import * as core from "@actions/core";

import {Events, Inputs, State} from "./constants";
import * as utils from "./utils/actionUtils";

async function run(): Promise<void> {
    try {
        if (utils.isGhes()) {
            utils.logWarning("Cache action is not supported on GHES");
            return;
        }

        if (!utils.isValidEvent()) {
            utils.logWarning(
                `Event Validation Error: The event type ${
                    process.env[Events.Key]
                } is not supported because it's not tied to a branch or tag ref.`
            );
            return;
        }

        const state = utils.getCacheState();

        // Inputs are re-evaluted before the post action, so we want the original key used for restore
        const primaryKey = process.env.ENV_IDENTIFIER;
        console.log(`#2 core.getState(State.CachePrimaryKey): ${core.getState(State.CachePrimaryKey)}`)
        // const primaryKey = core.getState(State.CachePrimaryKey);
        if (!primaryKey) {
            utils.logWarning(`Error retrieving key from state.`);
            return;
        }

        if (utils.isExactKeyMatch(primaryKey, state)) {
            console.info(
                `Cache hit occurred on the primary key ${primaryKey}, not saving cache.`
            );
            return;
        }

        let cachePaths: string[];
        // @ts-ignore
        cachePaths = [process.env.ENV_CACHE];
        // const cachePaths = utils.getInputAsArray(Inputs.Path, {required: true});

        try {
            await cache.saveCache(cachePaths, primaryKey, {
                uploadChunkSize: utils.getInputAsInt(Inputs.UploadChunkSize)
            });
        } catch (error) {
            if (error.name === cache.ValidationError.name) {
                throw error;
            } else if (error.name === cache.ReserveCacheError.name) {
                console.info(error.message);
            } else {
                utils.logWarning(error.message);
            }
        }
    } catch (error) {
        utils.logWarning(error.message);
    }
}

run();

export default run;
