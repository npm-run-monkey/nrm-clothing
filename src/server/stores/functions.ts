import { stores } from "./stores";

setImmediate(() =>
{
    stores.forEach((store) =>
    {
        global.exports["nrm-lib"].constructPed(store.model, store.x, store.y, store.z, 360, "nrm-clothing:client:client:openClothingMenu");
    });
});