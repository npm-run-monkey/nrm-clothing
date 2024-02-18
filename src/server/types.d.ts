interface OutfitComponent
{
    type: "item" | "prop";
    drawable: number;
    texture: number;
    componentId: number;
    title: string;
}

interface QueryRes<T>
{
    rowCount: number;
    rows: T[];
}

interface getPlayerOutfitByCidRes
{
    outfit: string;
}