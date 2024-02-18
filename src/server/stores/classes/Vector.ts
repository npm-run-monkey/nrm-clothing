class Vector
{
    private readonly x: number;
    private readonly y: number;
    private readonly z: number;

    constructor(x: number, y: number, z: number)
    {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public distanceTo(other: Vector): number
    {
        const dx = this.x - other.x;
        const dy = this.y - other.y;
        const dz = this.z - other.z;
        return Math.sqrt(dx * dx + dy * dy + dz * dz);
    };
};

export default Vector;