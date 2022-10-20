﻿using Forum_API.Models;
using Forum_API.Repository.Repository_Interfaces;

namespace Forum_API.Repository.Reposiory_Models
{
    public class ReactRepository : BaseRepository<React>, IReactRepository
    {
        public ReactRepository(Repository_Context repository_Context)
            : base(repository_Context)
        { 
        }
    }
}
