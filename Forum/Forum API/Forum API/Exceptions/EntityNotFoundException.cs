﻿namespace Forum_API.Exceptions
{
    public class EntityNotFoundException : Exception
    {
        public EntityNotFoundException(string message)
         : base(message)
        {
        }

        public EntityNotFoundException()
        { 
        }
    }
}
