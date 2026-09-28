# rag-architect

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/rag-architect/SKILL.md`
Description: Use when the user asks to design RAG pipelines, optimize retrieval strategies, choose embedding models, implement vector search, or build knowledge retrieval systems.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# RAG Architect - POWERFUL

## Overview

The RAG (Retrieval-Augmented Generation) Architect skill provides comprehensive tools and knowledge for designing, implementing, and optimizing production-grade RAG pipelines. This skill covers the entire RAG ecosystem from document chunking strategies to evaluation frameworks, enabling you to build scalable, efficient, and accurate retrieval systems.

## Core Competencies

### 1. Document Processing & Chunking Strategies

#### Fixed-Size Chunking
- **Character-based chunking**: Simple splitting by character count (e.g., 512, 1024, 2048 chars)
- **Token-based chunking**: Splitting by token count to respect model limits
- **Overlap strategies**: 10-20% overlap to maintain context continuity
- **Pros**: Predictable chunk sizes, simple implementation, consistent processing time
- **Cons**: May break semantic units, context boundaries ignored
- **Best for**: Uniform documents, when consistent chunk sizes are critical

#### Sentence-Based Chunking
- **Sentence boundary detection**: Using NLTK, spaCy, or regex patterns
- **Sentence grouping**: Combining sentences until size threshold is reached
- **Paragraph preservation**: Avoiding mid-paragraph splits when possible
- **Pros**: Preserves natural language boundaries, better readability
- **Cons**: Variable chunk sizes, potential for very short/long chunks
- **Best for**: Narrative text, articles, books

#### Paragraph-Based Chunking
- **Paragraph detection**: Double newlines, HTML tags, markdown formatting
- **Hierarchical splitting**: Respecting document structure (sections, subsections)
- **Size balancing**: Merging small paragraphs, splitting large ones
- **Pros**: Preserves logical document structure, maintains topic coherence
- **Cons**: Highly variable sizes, may create very large chunks
- **Best for**: Structured documents, technical documentation

#### Semantic Chunking
- **Topic modeling**: Using TF-IDF, embeddings similarity for topic detection
- **Heading-aware splitting**: Respecting document hierarchy (H1, H2, H3)
- **Content-based boundaries**: Detecting topic shifts using semantic similarity
- **Pros**: Maintains semantic coherence, respects document structure
- **Cons**: Complex implementation, computationally expensive
- **Best for**: Long-form content, technical manuals, research papers

#### Recursive Chunking
- **Hierarchical approach**: Try larger chunks first, recursively split if needed
- **Multi-level splitting**: Different strategies at different levels
- **Size optimization**: Minimize number of chunks while respecting size limits
- **Pros**: Optimal chunk utilization, preserves context when possible
- **Cons**: Complex logic, potential performance overhead
- **Best for**: Mixed content types, when chunk count optimization is important

#### Document-Aware Chunking
- **File type detection**: PDF pages, Word sections, HTML elements
- **Metadata preservation**: Headers, footers, page numbers, sections
- **Table and image handling**: Special processing for non-text elements
- **Pros**: Preserves document structure and metadata
- **Cons**: Format-specific implementation required
- **Best for**: Multi-format document collections, when metadata is important

### 2. Embedding Model Selection

#### Dimension Considerations
- **128-256 dimensions**: Fast retrieval, lower memory usage, suitable for simple domains
- **512-768 dimensions**: Balanced performance, good for most applications
- **1024-1536 dimensions**: High quality, better for complex domains, higher cost
- **2048+ dimensions**: Maximum quality, specialized use cases, significant resources

#### Speed vs Quality Tradeoffs
- **Fast models**: sentence-transformers/all-MiniLM-L6-v2 (384 dim, ~14k tokens/sec)
- **Balanced models**: sentence-transformers/all-mpnet-base-v2 (768 dim, ~2.8k tokens/sec)
- **Quality models**: text-embedding-ada-002 (1536 dim, OpenAI API)
- **Specialized models**: Domain-specific fine-tuned models

#### Model Categories
- **General purpose**: all-MiniLM, all-mpnet, Universal Sentence Encoder
- **Code embeddings**: CodeBERT, GraphCodeBERT, CodeT5
- **Scientific text**: SciBERT, BioBERT, ClinicalBERT
- **Multilingual**: LaBSE, multilingual-e5, paraphrase-multilingual

### 3. Vector Database Selection

#### Pinecone
- **Managed service**: Fully hosted, auto-scaling
- **Features**: Metadata filtering, hybrid search, real-time updates
- **Pricing**: $70/month for 1M vectors (1536 dim), pay-per-use scaling
- **Best for**: Production applications, when managed service is preferred
- **Cons**: Vendor lock-in, costs can scale quickly

#### Weaviate
- **Open source**: Self-hosted or cloud options available
- **Features**: GraphQL API, multi-modal search, automatic vectorization
- **Scaling**: Horizontal scaling, HNSW indexing
- **Best for**: Complex data types, when GraphQL API is preferred
- **Cons**: Learning curve, requires infrastructure management

#### Qdrant
- **Rust-based**: High performance, low memory footprint
- **Features**: Payload filtering, clustering, distributed deployment
- **API**: REST and gRPC interfaces
- **Best for**: High-performance requirements, resource-constrained environments
- **Cons**: Smaller community, fewer integrations

#### Chroma
- **Embedded database**: SQLite-based, easy local development
- **Features**: Collections, metadata filtering, persistence
- **Scaling**: Limited, suitable for prototyping and small deployments
- **Best for**: Development, testing, small-scale applications
- **Cons**: Not suitable for production scale

#### pgvector (PostgreSQL)
- **SQL integration**: Leverage existing PostgreSQL infrastructure
- **Features**: ACID compliance, joins with relational data, mature ecosystem
- **Performance**: ivfflat and HNSW indexing, parallel query processing
- **Best for**: When you already use PostgreSQL, need ACID compliance
- **Cons**: Requires PostgreSQL expertise, less specialized than purpose-built DBs

### 4. Retrieval Strategies

#### Dense Retrieval
- **Semantic similarity**: Using embedding cosine similarity
- **Advantages**: Captures semantic meaning, handles paraphrasing well
- **Limitations**: May miss exact keyword matches, requires good embeddings
- **Implementation**: Vector similarity search with k-NN or ANN algorithms

#### Sparse Retrieval
- **Keyword-based**: TF-IDF, BM25, Elasticsearch
- **Advantages**: Exact keyword matching, interpretable results
- **Limitations**: Misses semantic similarity, vulnerable to vocabulary mismatch
- **Implementation**: Inverted indexes, term frequency analysis

#### Hybrid Retrieval
- **Combination approach**: Dense + sparse retrieval with score fusion
- **Fusion strategies**: Reciprocal Rank Fusion (RRF), weighted combination
- **Benefits**: Combines semantic understanding with exact matching
- **Complexity**: Requires tuning fusion weights, more complex infrastructure

#### Reranking
- **Two-stage approach**: Initial retrieval followed by reranking
- **Reranking models**: Cross-encoders, special

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
