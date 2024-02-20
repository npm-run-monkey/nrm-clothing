import { stores } from "./stores";

setImmediate(() =>
{
    stores.forEach((store) =>
    {
        global.exports["nrm-lib"].constructPed(store.model, store.x, store.y, store.z, store.h, [ { name: "Kledingwinkel", event: "nrm-clothing:server:client:openClothingMenu"}, { name: "Cutie", event: "nrm-clothing:server:client:cutie"} ] as Entry[]);
    });
});