-- Create nodes table to track available GPU hardware resources
CREATE TABLE public.nodes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    worker_ip TEXT NOT NULL,
    port INTEGER NOT NULL,
    gpu_model TEXT NOT NULL,
    vram_gb INTEGER NOT NULL,
    status TEXT DEFAULT 'IDLE',
    last_heartbeat TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create jobs table to track tasks and orchestration matching metrics
CREATE TABLE public.jobs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    client_name TEXT NOT NULL,
    dataset_size_mb INTEGER NOT NULL,
    task_type TEXT NOT NULL,
    status TEXT DEFAULT 'PENDING',
    master_node_id UUID REFERENCES public.nodes(id),
    worker_node_id UUID REFERENCES public.nodes(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
