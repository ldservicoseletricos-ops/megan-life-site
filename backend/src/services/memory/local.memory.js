const memory = [];

export const localMemory = {
  save(item) {
    const record = { id: String(Date.now()), createdAt: new Date().toISOString(), ...item };
    memory.push(record);
    return record;
  },
  search(query = '') {
    const q = String(query).toLowerCase();
    return memory.filter((item) => JSON.stringify(item).toLowerCase().includes(q)).slice(-20);
  },
};
